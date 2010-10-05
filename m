From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [REGRESSION] no sound on T60 laptop (HDA Intel)
Date: Tue, 05 Oct 2010 22:35:28 +0200
Message-ID: <E1P3EES-0005SV-Sr@pomaz-ex.szeredi.hu>
References: <E1P33mT-0003qa-Fv@pomaz-ex.szeredi.hu> <s5hwrpxnf41.wl%tiwai@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <s5hwrpxnf41.wl%tiwai@suse.de> (message from Takashi Iwai on Tue,
	05 Oct 2010 11:49:50 +0200)
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: miklos@szeredi.hu, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 05 Oct 2010, Takashi Iwai wrote:
> In anyway, if this is reproducible, get alsa-info.sh output before and
> after suspend.  It'll give more information of HD-audio and sound
> driver status.

No significant difference before and after the suspend

...

Bisected it to commit 3f50ac6a0e "ALSA: hda - Fix stream and
channel-ids codec-bus wide"

Reverting this on latest git fixes the sound.

Thanks,
Miklos
