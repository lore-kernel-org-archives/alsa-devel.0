From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] ASoC: MAX9860: new driver
Date: Thu, 12 May 2016 09:54:18 +0200
Message-ID: <5e9b7d83-95ac-256a-a1e6-ca69da141c3a@axentia.se>
References: <1462892797-1147-1-git-send-email-peda@axentia.se>
 <20160511150937.GK6261@sirena.org.uk>
 <65bdbaea-fe4e-bbd5-335d-a8d594936cbe@axentia.se>
 <20160511205052.GU6261@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160511205052.GU6261@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

[Dropping the DT crowd]

On 2016-05-11 22:50, Mark Brown wrote:
> On Wed, May 11, 2016 at 10:12:56PM +0200, Peter Rosin wrote:
>> On 2016-05-11 17:09, Mark Brown wrote:
>>> On Tue, May 10, 2016 at 05:06:37PM +0200, Peter Rosin wrote:
> 
>>>> This driver does not support sidetone since the DVST register field is
>>>> backwards with the mute near the maximum level instead of the minimum.
> 
>>> Why would that be an issue?  We support volume controls in either
>>> direction.
> 
>> I asked about this last week (or so), maybe that question explains the
>> situation?
> 
>> http://www.spinics.net/lists/alsa-devel/msg49675.html
> 
> If you don't CC maintainers the chances are your mails just won't get
> seen...

To me, it feels rude to single out people when asking general questions.
I my world, these kind of questions are exactly what mailing lists are
for. But ok, lesson learned, noone actually reads alsa-devel...

> You should change DAPM so that it understands what your control is
> doing, possibly by using custom accessors though it seems like something
> in the vein of the invert flag ought to do the trick.  You don't want to
> actually use the invert flag since increasing values do mean increasing
> volume but something along those lines.  Possibly doing it by parsing
> the TLV for a mute value at probe time might make sense?

It seems nicest to do the runtime scan of the TLV for the mute value when
the control is attached (or thereabouts), i.e. your last suggestion, and
then in snd_soc_dapm_put_volsw() change the line

	connect = !!val;

into

	connect = val != something->mute_value;

However, I don't see where to add the runtime scan of the TLV, and I don't
see what "something" in the above should be, i.e. where I should store the
result of the TLV scan?

Also, fixing DAPM to understand this problematic field will probably not
make any difference for the confusion seen in alsamixer. This, coupled with
the fact that the sidetone is not a function that I need makes me less than
eager to take this on...

Cheers,
Peter
