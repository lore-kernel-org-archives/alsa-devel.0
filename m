From: "Chaithrika U S" <chaithrika@ti.com>
Subject: Re: Sound support for Neuros OSD2 Davinci based board.
Date: Thu, 26 Nov 2009 18:57:19 +0530
Message-ID: <002e01ca6e9c$2dab6040$890220c0$@com>
References: <4B0E7D5E.3080906@chelcom.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 616AD2444E
	for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2009 14:29:49 +0100 (CET)
In-Reply-To: <4B0E7D5E.3080906@chelcom.ru>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "'A. Porodko'" <panda@chelcom.ru>, 'Liam Girdwood' <lrg@slimlogic.co.uk>, 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, 'Jaroslav Kysela' <perex@perex.cz>, 'Takashi Iwai'
List-Id: alsa-devel@alsa-project.org

Hello,

On Thu, Nov 26, 2009 at 18:36:38, A. Porodko wrote:
> Hello,
> 
> Here is a patch for Neuros OSD2 Davinci (DM6446) based board sound support.
> Patch made against 2.6.32-rc6 kernel.
> ------------------------------------------
> 
> --
> Best regards
> Andrey A. Porodko
>  
> 
> 
@@ -246,6 +249,9 @@ static int __init evm_init(void)
 	if (machine_is_davinci_evm()) {
 		evm_snd_dev_data = &evm_snd_devdata;
 		index = 0;
+	} else if (machine_is_neuros_osd2()) {
+		evm_snd_dev_data = &evm_snd_devdata;
+		index = 0;

The above can be combined with the check for DaVinci EVM
	if (machine_is_davinci_evm() ||
				(machine_is_neuros_osd2()) {
 		evm_snd_dev_data = &evm_snd_devdata;
 		index = 0;
	
Regards, 
Chaithrika
