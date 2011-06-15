From: "Ashish P. Chavan" <Ashish.Chavan@kpitcummins.com>
Subject: Need Help About Submitting Updates to Existing ASoC
 Codec Driver [Re Post]
Date: Wed, 15 Jun 2011 11:15:42 +0530
Message-ID: <F56EA673D3E56E48804FE2B0D23EFD2D22FD94CFDE@KCINPUNHJCMS01.kpit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from CH1EHSOBE014.bigfish.com (ch1ehsobe004.messaging.microsoft.com
	[216.32.181.184])
	by alsa0.perex.cz (Postfix) with ESMTP id A675C24660
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jun 2011 07:45:51 +0200 (CEST)
Received: from mail49-ch1 (localhost.localdomain [127.0.0.1])	by
	mail49-ch1-R.bigfish.com (Postfix) with ESMTP id E5CCEC800DD	for
	<alsa-devel@alsa-project.org>; Wed, 15 Jun 2011 05:45:47 +0000 (UTC)
Received: from CH1EHSMHS013.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.244])	by mail49-ch1.bigfish.com (Postfix) with ESMTP id
	A38C8B5004E
	for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2011 05:45:47 +0000 (UTC)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

[Sorry for my previous post in which outlook messed up line breaks,
Please ignore it. This is repost of the same message.]

Hi,
   We are in the process of upgrading codec driver for Dialog's DA7210 codec 
(sound/soc/codecs/da7210.c). Existing driver in mainline is just bare minimum 
and doesn't support many of the chip's features. Our update would be a major 
functionality update in nature.

Our final goal is to get the updated driver merged into mainline kernel. 
For this we just want to make sure that we follow correct process. As far as I 
understood from alsa-project.org and other resources, the normal process is to 
submit the patch against alsa-kenel (git.alsa-project.org:alsa-kernel.git alsa-kernel)
and get it reviewed by maintainers there. Once all maintainers are satisfied 
with the patch, it will be eventually put in to for-linus branch and get in to mainline.

Is this the correct approach and path to achieve our goal? Is there any 
obvious misunderstanding or missing step(s) here?


Thanks,

-- Ashish

----------------------------------------------------------------------------
|| Linux Is User Friendly, It's Just Selective About Who It's Friend' Are ||
----------------------------------------------------------------------------
