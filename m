From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [Alsa-devel] RFC: OSS driver removal, a slightly different
 approach
Date: Fri, 20 Jan 2006 15:25:54 +0100 (MET)
Message-ID: <Pine.LNX.4.61.0601201524080.22940@yvahk01.tjqt.qr>
References: <20060119174600.GT19398@stusta.de> <200601191947.20748.pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751021AbWATO0d@vger.kernel.org>
In-Reply-To: <200601191947.20748.pzad@pobox.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zubaj <pzad@pobox.sk>
Cc: alsa-devel@lists.sourceforge.net, Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

>Hi,
>
>On Thursday 19 January 2006 18:46, Adrian Bunk wrote:
>> SOUND_EMU10K1
>> - ALSA #1735 (OSS emulation 4-channel mode rear channels not working)
>
>If I understand alsa - oss emulation correctly, I think, this will be not 
>fixed soon (my opinion - never). This is too much work for too little gain.

On that way, I'd like to inquiry something:
I have a card that works with the snd-cs46xx module.
With the OSS emulation (/dev/dsp), I can only output 2 channels, and the 
other two must be sent to /dev/adsp. Is this intended? Would not it be 
easier to make /dev/dsp allow receiving an ioctl setting 4 channels?


Jan Engelhardt
-- 
