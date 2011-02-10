From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: [PATCH] asihpi: Update from 4.04 to 4.06
Date: Fri, 11 Feb 2011 12:19:49 +1300
Message-ID: <4D547295.9050005@audioscience.com>
References: <1297311981-30448-1-git-send-email-linux@audioscience.com>
	<s5h39nvdbge.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 45F0D24152
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2011 00:20:03 +0100 (CET)
Received: from [192.168.36.2]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LGF000I2CT12M10@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Fri, 11 Feb 2011 12:19:50 +1300 (NZDT)
In-reply-to: <s5h39nvdbge.wl%tiwai@suse.de>
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

On 11/02/11 06:52, Takashi Iwai wrote:
> At Thu, 10 Feb 2011 17:25:53 +1300,
> linux@audioscience.com wrote:
>>
>> This patch series updates asihpi driver from version 4.04 to 4.06
> Thanks for the patches.
> Many of them include nice cleanups indeed.

Thanks Takashi.

Please also update alsa-firmware/asihpi with the contents of:

http://audioscience.com/internet/download/drivers/released/v4/06/00/asihpi-firmware-40600.7z

This update is necessary for driver and dsp firmware to function
correctly together.

> One problem was that you added the inclusion of adriver.h with strange
> ifdefs.  This should be removed in the kernel code.
> (And adriver.h is anyway included first in alsa-driver build tree, so
>  it's unnecessary to add something there.)
> I corrected it manually, but applied the rest as is.

Thanks.

I can wipe the sweat from my brow now. (It took me quite some time to
generate the git commits from our internal VCS history, and I really
hoped I wouldn't have to revise the patches!)

--
Eliot
