From: "Ashish P. Chavan" <Ashish.Chavan@kpitcummins.com>
Subject: Need Help About Submitting Updates to Existing ASoC
	Codec Driver
Date: Wed, 15 Jun 2011 10:22:22 +0530
Message-ID: <F56EA673D3E56E48804FE2B0D23EFD2D22FD94CFDA@KCINPUNHJCMS01.kpit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE002.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) by alsa0.perex.cz (Postfix) with ESMTP id EA71810382B
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jun 2011 06:52:35 +0200 (CEST)
Received: from mail117-tx2 (localhost.localdomain [127.0.0.1])	by
	mail117-tx2-R.bigfish.com (Postfix) with ESMTP id AB4E93402B9	for
	<alsa-devel@alsa-project.org>; Wed, 15 Jun 2011 04:52:30 +0000 (UTC)
Received: from TX2EHSMHS006.bigfish.com (unknown [10.9.14.243])	by
	mail117-tx2.bigfish.com (Postfix) with ESMTP id 8784E1CA004B	for
	<alsa-devel@alsa-project.org>; Wed, 15 Jun 2011 04:52:30 +0000 (UTC)
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

Hi,
   We are in the process of upgrading codec driver for Dialog's DA7210 codec (sound/soc/codecs/da7210.c). Existing driver in mainline is just bare minimum and doesn't support many of the chip's features. Our update would be a major functionality update in nature.

Our final goal is to get the updated driver merged into mainline kernel. For this we just want to make sure that we follow correct process. As far as I understood from alsa-project.org and other resources, the normal process is to submit the patch against alsa-kenel (git.alsa-project.org:alsa-kernel.git alsa-kernel) and get it reviewed by maintainers there. Once all maintainers are satisfied with the patch, it will be eventually put in to for-linus branch and get in to mainline. Is this the correct approach and path to achieve our goal? Is there any obvious misunderstanding or missing step(s) here?


Thanks,

-- Ashish

----------------------------------------------------------------------------
|| Linux Is User Friendly, It's Just Selective About Who It's Friend' Are ||
----------------------------------------------------------------------------
