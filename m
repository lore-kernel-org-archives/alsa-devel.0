From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: [PATCH] Sync with AudioScience current CVS at
	version 4.03.04
Date: Wed, 03 Feb 2010 09:45:26 +1300
Message-ID: <4B688EE6.8060209@audioscience.com>
References: <4B67DF4B.2050308@audioscience.com> <s5h1vh3ad75.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id E8445103861
	for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2010 21:45:35 +0100 (CET)
Received: from [192.168.1.6]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0KX800L6OEZTLQ40@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Wed, 03 Feb 2010 09:45:30 +1300 (NZDT)
In-reply-to: <s5h1vh3ad75.wl%tiwai@suse.de>
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
> At Tue, 02 Feb 2010 21:16:11 +1300,
> Eliot Blennerhassett wrote:
>> Greetings,
>>
>> The just submitted patch requires matching firmware
>> http://audioscience.com/internet/download/firmware/dspbins40304.zip
>>
>> As usual, my apologies for the large patch.  Unfortunately it was not
>> possible to split into unrelated subpatches without manually recreating
>> the commit history from our CVS repository.
> 
> Thanks for the patch.  I applied now together with the firmware update.

Thank you.

> I suppose the new firmware is still compatible with the older one?
> I'm asking this because the files are overridden.

In this case, the firmware and driver are a pair that must go together.
I.e. both the driver and the firmware must be updated together.

If the versions do not match, a warning will be logged.

However, now you mention it, I will look at making it a failure if the
major version of driver vs fimware does not match (we changed from 3. to
4. because the message format is incompatible).
I'll follow up with another patch in the next few days.

regards

Eliot
