From: Konstantin Khlebnikov <khlebnikov@openvz.org>
Subject: Re: [ALSA hda 3.4-rc] suspend2ram regression in snd_hda_intel
Date: Sun, 06 May 2012 12:32:14 +0400
Message-ID: <4FA6370E.9000702@openvz.org>
References: <4FA38371.9020205@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FA38371.9020205@openvz.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Konstantin Khlebnikov wrote:
> Mainline commit 785f857d1cb0856b612b46a0545b74aa2596e44a
> ("ALSA: hda - Set codec to D3 forcibly even if not used")
> breaks sound for my notebook (thinkpad x220),
> looks like codec cannot wake from power-save state after resume.
> After reverting looks like all works fine.
>
> how to reproduce:
> * unplug the power cord (to enable hda power safe mode)
> * play something and stop
> * wait until the background noise disappears (codec went into power-save mode)
> * suspend
> * resume
> * play something again and hear the silence
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Bump

BTW, I don't see any locks around hda power-save code, for example  hda_power_work() reads
codec->power_on and codec->power_count without any locks. This seems racy.
