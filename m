From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH alsa-lib emu10k1.conf 1/1] Fix "front"
	device of SB Live! Platinum
Date: Thu, 21 Apr 2011 21:25:17 +0800
Message-ID: <BANLkTimQXg5SJiMiPOJOsiOtxTHzTfjgMQ@mail.gmail.com>
References: <BANLkTintENV=X7VGyratXNYLOGRGQrp84g@mail.gmail.com>
	<s5h7hapf6kh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A8C5E103962
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Apr 2011 15:25:17 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1132910fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2011 06:25:17 -0700 (PDT)
In-Reply-To: <s5h7hapf6kh.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/4/20 Takashi Iwai <tiwai@suse.de>

> At Tue, 12 Apr 2011 10:17:32 +0800,
> Raymond Yau wrote:
> >
> > Since commit 148c2b8e7c12b4ab8a039995fa9904e7e1300cc4. Front channels via
> > fxbus 8 and 9
> >
> > No sound from the front jack of SB Live! platinum CT4760P when the
> > application using "front" device but sound from front jack when
> application
> > using hw:0,0 and /dev/dsp
> >
> > Error message " I: (alsa-lib)setup.c: Cannot lock ctl elem*"* when
> > Pulseaudio server open "front" device for playback and capture at the
> same
> > time because of locked "EMU10K1 Send PCM Volume"
>
> These are two different problems.  The latter can be solved by removing
> the locks in hooks.
>
> But reverting the whole FX routing causes a regression, so can't be
> taken as is.  If the FX route 8/9 can't be used for the front output
> on some models, the driver should notify it somehow and we need to
> handle differently for them.  Typically, the driver sets a different
> driver-name so that alsa-lib can use the corresponding card config
> file.
>
> I'll fix the lock issue first.
>
>
> thanks,
>
> Takashi
>

Your patch only fix the lock issue only.

If one application using "front" device for playback , the audio signal
changed from right to left when the other application using "rear" device
for recording.,

if one application using "hw:0,0" for playback , stop to hear any audio
whenever other application using "rear" device for recording

so this look like the playback is affected whenever other application use
"front" or "rear" device for capturing,
