From: "Geoffrey D. Bennett" <g@b4.vu>
Subject: Re: [PATCH V4] ALSA: usb-audio: Scarlett Gen 2 mixer
	interface
Date: Wed, 10 Jul 2019 23:36:47 +0930
Message-ID: <20190710140647.GA29152@b4.vu>
References: <20190709132605.GA25293@b4.vu> <s5hk1crtinr.wl-tiwai@suse.de>
 <20190709162430.GA25766@b4.vu> <s5h1ryzi108.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from b4.vu (b4.vu [203.16.231.147])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91CB7F800E2
 for <alsa-devel@alsa-project.org>; Wed, 10 Jul 2019 16:06:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h1ryzi108.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 09, 2019 at 07:14:15PM +0200, Takashi Iwai wrote:
> On Tue, 09 Jul 2019 18:24:30 +0200,
> Geoffrey D. Bennett wrote:
[...]
> > > > +static int scarlett_gen2_mixer_enable;
> > > > +module_param(scarlett_gen2_mixer_enable, int, 0444);
> > > > +MODULE_PARM_DESC(scarlett_gen2_mixer_enable,
> > > > +		 "Focusrite Scarlett Gen 2 Mixer Driver Enable");
> > > 
> > > Do we need this?  If disabling the quirk is really required, it should
> > > be implemented rather in a generic option, instead.
> > 
> > Actually it would be best to have it disabled by default as I have had
> > two reports from people who tried this mixer driver and it broke audio
> > for them.
> 
> Hm, and these have the same USB device ID?

Yes, same device ID. I couldn't see any significant difference between
mine and theirs usbmon trace and lsusb -v output.

[...]
> I guess you can use chip->setup value for the quirk-specific
> configuration as a start.  It's a bit hackish but the parameter is
> already there for long time, hence you don't need to add any extra
> stuff for that.

Got it. Have implemented and will resend soon.

In your other email you wrote:

> Canceling the pending work is the right thing for suspend, but we need
> reconsidering the side effect.  For example, the device might be
> removed while the machine is in sleep.  And the purpose of the
> scheduled work is to sync the config to NVRAM.  That is, it should
> have been done before going to suspend.  Then we don't have to resume
> the task at resume, too.
> 
> That said, the best would be:
> - cancel the pending work, check the return value
> - re-execute the work immediately (delay=0) if the work was canceled
>   in the above, and do flush -- or just call the function directly

I agree and have implemented that as well.

Thanks,
Geoffrey.
