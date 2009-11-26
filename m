From: "A. Porodko" <panda@chelcom.ru>
Subject: Re: Patch for Neuros OSD2 board sound support
Date: Thu, 26 Nov 2009 16:43:36 +0500
Message-ID: <4B0E69E8.6030902@chelcom.ru>
References: <4B0E66D5.3090807@chelcom.ru> <1259235615.3639.7.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000804080502060002040509"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.intersvyaz.net (mail.is74.ru [83.142.161.14])
	by alsa0.perex.cz (Postfix) with ESMTP id 00DFB243BA
	for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2009 12:43:43 +0100 (CET)
In-Reply-To: <1259235615.3639.7.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000804080502060002040509
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit

Sure.
Here it is.

Liam Girdwood wrote:
> Hi Andrey,
>
> Could you resend and also CC the alsa-devel mailing list.
>
> Thanks
>
> Liam
>
> On Thu, 2009-11-26 at 16:30 +0500, A. Porodko wrote:
>   
>> Hello,
>>
>> I would like to propose a patch for Neuros OSD2 (davinci SOC DM6446)
>> based board.
>> Would you be so kind to consider it, please? Corresponded patch for
>> board code I've already submitted to davinci group.
>> Thank you in advance.
>>
>>     
>
>
>   


-- 
Best regards
Andrey A. Porodko
 


--------------000804080502060002040509
Content-Type: text/x-patch;
 name="0005-Davinci-sound-soc-driver-patch-for-Neuros-OSD2-board.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0005-Davinci-sound-soc-driver-patch-for-Neuros-OSD2-board.pa";
 filename*1="tch"

>From 72b5b0efa71d0ca0bbe3a0c3ab577ee365385a28 Mon Sep 17 00:00:00 2001
From: Andrey Porodko <panda@chelcom.ru>
Date: Mon, 23 Nov 2009 13:56:53 +0500
Subject: [PATCH] Davinci sound soc driver patch for Neuros OSD2 board support.

Signed-off-by: Andrey Porodko <panda@chelcom.ru>
---
 sound/soc/davinci/davinci-evm.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 67414f6..ffdd30e 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -55,6 +55,9 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 	else if (machine_is_davinci_evm())
 		sysclk = 12288000;
 
+	else if (machine_is_neuros_osd2())
+		sysclk = 27000000;
+
 	else if (machine_is_davinci_da830_evm() ||
 				machine_is_davinci_da850_evm())
 		sysclk = 24576000;
@@ -246,6 +249,9 @@ static int __init evm_init(void)
 	if (machine_is_davinci_evm()) {
 		evm_snd_dev_data = &evm_snd_devdata;
 		index = 0;
+	} else if (machine_is_neuros_osd2()) {
+		evm_snd_dev_data = &evm_snd_devdata;
+		index = 0;
 	} else if (machine_is_davinci_dm355_evm()) {
 		evm_snd_dev_data = &evm_snd_devdata;
 		index = 1;
-- 
1.5.6.5


--------------000804080502060002040509
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000804080502060002040509--
