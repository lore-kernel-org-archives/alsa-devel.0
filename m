From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH v2] ASoC: da7219: read fmw property to get
 mclk for non-dts systems
Date: Wed, 2 May 2018 10:13:55 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1E9782@SW-EX-MBX01.diasemi.com>
References: <1525080203-18947-1-git-send-email-akshu.agrawal@amd.com>
 <2E89032DDAA8B9408CB92943514A0337014C1E93BC@SW-EX-MBX01.diasemi.com>
 <20180501205006.GE2714@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.114])
 by alsa0.perex.cz (Postfix) with ESMTP id 055DD266F44
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 12:13:58 +0200 (CEST)
In-Reply-To: <20180501205006.GE2714@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, "djkurtz@chromium.org" <djkurtz@chromium.org>, "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org

On 01 May 2018 21:50, Mark Brown wrote:

> On Mon, Apr 30, 2018 at 07:05:19PM +0000, Adam Thomson wrote:
> 
> > There is already a means via DT to specify the MCLK for a device using the
> > generic clock DT bindings, and this driver already uses that. Should ACPI not
> > have something similar to that which is generic, rather than adding device
> > specific bindings/properties to achieve the same? There will be other drivers
> > that will want to do the same.
> 
> There's a lot of things that ACPI *should* do but doesn't - it's a bit
> of a shambles how ACPI standards get defined and what's there is not
> really intended to handle systems like these semi-embedded ones.  One of
> the big gaps in ACPI is that it has no handling at all of clocks, that's
> supposed to be done transparently by firmware in the ACPI model.  What a
> lot of the embedded Intel people have been doing is coopting the DT
> bindings wholesale for ACPI systems but that has problems when you get
> into areas which should be handled in some way on ACPI systems like
> power and unfortunately clocks are kind of power adjacent so might be a
> bit sketchy here.

Yes I was aware that previously that was the case, although have not followed
this for a while. It just feels here that we should aim for something more
generic rather than a device specific property/binding, if possible, as that
feels messy to me and I'm sure other drivers could take advantage of this as
well. I've not looked at the clock code in too much detail though, at least with
regards to this area, so not sure how feasible that is.

As a suggestion for ACPI would it be possible to re-use the 'clock-names'
property and add something in the framework to handle this?
