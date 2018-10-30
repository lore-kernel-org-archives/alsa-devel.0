From: Rohit Kumar <rohitkr@codeaurora.org>
Subject: Bug in hdmi codec driver in DPCM
Date: Tue, 30 Oct 2018 20:20:53 +0530
Message-ID: <52692082-70ce-9616-6a0b-4c68ed2c61c0@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F33426751A
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2018 15:51:00 +0100 (CET)
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
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org, plai@codeaurora.org, bgoswami@codeaurora.org
List-Id: alsa-devel@alsa-project.org

Hi,

We are facing crash in hdmi codec driver when we use DPCM based 
dai-links. Crash is happening in hdmi_codec_eld_chmap() while accessing 
chmap_info struct during hdmi_codec_startup(). However, chmap_info 
struct is allocated in hdmi_codec_pcm_new() which is only called in 
non-DPCM based dai-links.

Below is the crash stack:

[61.635493] Unable to handle kernel NULL pointer dereference at virtual 
address 00000018

.....

[61.666696]CM = 0, WnR = 1

[61.669778] user pgtable: 4k pages, 39-bit VAs, pgd = ffffffc0d6633000

[61.676526] [0000000000000018] *pgd=0000000153fc8003, 
*pud=0000000153fc8003, *pmd=0000000000000000

[61.685793] Internal error: Oops: 96000046 [#1] PREEMPT SMP

[61.722955] CPU: 7 PID: 2238 Comm: aplay Not tainted 4.14.72 #21

..

[61.740269] PC is at hdmi_codec_startup+0x124/0x164

[61.745308] LR is at hdmi_codec_startup+0xe4/0x164

..

We would probably need to move the implementation on pcm_new() to some 
other function to make it compatible with DPCM.

Can you please provide suggestions in solving the issue.


Thanks,

Rohit
