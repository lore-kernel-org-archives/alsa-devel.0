From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 2/2] ASoC: DA7219: Implement error check on reg read and write
Date: Wed, 5 Dec 2018 10:50:29 -0700
Message-ID: <CAGS+omCSrt_Fe5=qQc28Dc4GZB-jUH-7kVQ3-Cq6E15tTarxZQ@mail.gmail.com>
References: <1543948103-20752-1-git-send-email-akshu.agrawal@amd.com>
 <1543948103-20752-2-git-send-email-akshu.agrawal@amd.com> <AM5PR1001MB099412DDC3B33069BCFDC38B80AF0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <50cffd9e-74f4-b0af-5eed-3dad5f32d8f9@amd.com> <AM5PR1001MB0994CDEC9FB92DBCEB83892280A80@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20181205112832.GA6205@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205112832.GA6205@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Adam.Thomson.Opensource@diasemi.com, Akshu Agrawal <Akshu.Agrawal@amd.com>, Alexander.Deucher@amd.com, Support.Opensource@diasemi.com, Liam Girdwood <lgirdwood@gmail.com>, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 5, 2018 at 4:28 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Dec 05, 2018 at 10:21:04AM +0000, Adam Thomson wrote:
>
> > If the previous I2C access failed, how can we be sure that the write back to HW
> > of 0xFF even succeeds? More importantly these error returns won't necessarily
> > stop subsequent calls to controls within the Codec I believe, so you could still
> > see unwanted writes to HW via I2C, if I2C is sporadically operational. Again I
> > don't see this update resolving that. The key thing is to resolve why even just
> > one I2C transaction fails.
>
> Right, it's just not clear what we can constructively do if the I2C bus
> falls to bits other than log things and the I2C controllers will
> generally do that themselves.  There's no guarantee what made it
> through to the device or what will in future make it through to the
> device.

I agree, there is no guarantee here once things have gone wrong, and
the concerns above are reasonable.  However, in the real world, I2C
transactions do sometimes fail for various reasons.  The I2C (and
other bus) APIs have ways of reporting up their errors so callers can
take appropriate action.  This codec driver can run on all kinds of
hardware that can experience transient I2C errors, thus it sounds like
a reasonable idea to have the driver do some error checking on the
APIs it calls and take whatever action it can.  Just ignoring the
errors and proceeding like nothing is wrong is one option, but we can
probably do a little better by at least checking for errors, abort the
current operation, and pass up errors to higher layers when an i2c
transaction failure is detected.  If nothing else, this would enable
higher policy layers to take appropriate corrective action - for
example, if there is an i2c error when configuring a codec, it seems
advisable to report this up so that a machine driver would know to
abort and not turn on downstream amplifiers [I am assuming here that
something like this would happen, I don't know if the sound stack
really works this way].

Once the default "check, abort and report" error checking is in place,
we could perhaps think about actions that the driver could take to
recover from various failures, such as resetting the device or
unwinding previous transactions before aborting, or retrying....  but
those are all policy, and this patch is more mechanism that enables
policy.

As for this patch itself, I would recommend using
snd_soc_component_read rather than snd_soc_component_read32() which is
fundamentally broken and afaict should be removed, since there is no
way to distinguish between its error return "(u32)-1" and the valid
register value 0xffffffff.  (Edit: I notice that you did this in v2,
so please ignore, but still replying here since this seems to be where
the active discussion is).

-Dan
