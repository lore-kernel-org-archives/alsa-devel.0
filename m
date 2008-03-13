From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: [PATCH 3/5] asihpi: Remove HPI4000
Date: Fri, 14 Mar 2008 09:46:02 +1300
Message-ID: <47D9928A.30000@audioscience.com>
References: <200803061449.18512.linux@audioscience.com>
	<200803071232.52272.linux@audioscience.com>
	<s5h1w6eaov1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id F12C41038B6
	for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2008 21:46:09 +0100 (CET)
Received: from [192.168.1.4]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JXO00KQWSCRP030@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Fri, 14 Mar 2008 09:46:04 +1300 (NZDT)
In-reply-to: <s5h1w6eaov1.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Fri, 07 Mar 2008 12:32:52 +1300,
> Eliot Blennerhassett wrote:
>> On Thursday 06 March 2008 14:49:18 Eliot Blennerhassett wrote:
>>> Remove HPI4000
>> This also requires update to alsa-firmware/asihpi with files from 
>> http://audioscience.com/internet/download/firmware/dspbins30914.tar.gz
>>
>> dsp4*.bin are no longer required.
> 
> Oops, forgot to update this -- committed to HG tree now.

Thanks.


>> Also alsa-driver/pci/asihpi/hpi4000.* are no longer required.
>> AudioScience next stable driver release (3.10.0) will not include support for 
>> ASI4xxx cards.
>>
>> AudioScience will continue to maintain our version 3.08.xx with bugfixes for 
>> these cards and  ALSA 1.0.16 will be the last alsa release with support for 
>> ASI4xxx.

> OK.  BTW, what if the newer firmware is loaded onto the old driver?

Within limits (how far apart driver and firmware are) this will work. 
Mostly we are adding functions to the firmware, so old driver will work 
with new firmware but a new driver won't work with old firmware.
Sometimes old functions are deprecated, but we don't remove them 
straight away.


In the windows world our "driver" install includes driver, firmware, 
userspace dll, python bindings, and mixer application all matching.


> Would it be safer to rename the firmware file for each incompatible
> version?  If yes, we can change the asihpi driver code together with
> the firmware renames to couple tightly.

The firmware images contain the HPI version encoded in the header.  I 
will at least log a warning that the driver and firmware version do not 
match.

I guess its possible to use versioned file names. Did you have something 
in mind? Currently the filename is generated from an adapter ID:

sprintf(fw_name, "asihpi/dsp%04x.bin", nAdapter);

regards

--
Eliot
