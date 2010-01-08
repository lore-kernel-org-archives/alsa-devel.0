From: JASWINDERSINGH BRAR <jassi.brar@samsung.com>
Subject: Reforming s3c2443 ac97 driver
Date: Fri, 08 Jan 2010 05:28:51 +0000 (GMT)
Message-ID: <29946650.33531262928531169.JavaMail.weblogic@epml17>
Reply-To: jassi.brar@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by alsa0.perex.cz (Postfix) with ESMTP id BADA62459F
	for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2010 06:28:54 +0100 (CET)
Received: from ep_ms11_bk (mailout3.samsung.com [203.254.224.33])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KVW0009KXW36J@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 08 Jan 2010 14:28:51 +0900 (KST)
Received: from ep_spt03 (ms11.samsung.com [203.254.225.106])
	by ms11.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTP id <0KVW0040TXW3ZF@ms11.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 08 Jan 2010 14:28:51 +0900 (KST)
Content-return: prohibited
MIME-version: 1.0
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "graeme.gregory@wolfsonmicro.com" <graeme.gregory@wolfsonmicro.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, SeungHyun Choi <sh428.choi@samsung.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

Hi,
     Right now the S3C2443's AC97_ver2.0 controller driver isn't flexible enough
to handle newer SoCs.
   In order to prepare ground for supporting 64xx and S5Pxxxx the extant driver
needs to be reformed, and that is what i am planning to do next.

I plan to do the following:-
1) User platform_driver structure to detect and manage AC97 controller
platform devices.
2) Remove hardcoded parameters(DMA, IO address, IRQ etc) and pass via
platform resources.
3) Initialize platform specific stuff by callback pointers to platform code(cfg_gpio)

Objections, suggestions welcome.


------------------------------- 
Jaswinder Singh Brar
Senior Engineer
Linux OS Team
Application Processor Development 
System LSI Division
SAMSUNG Electronics Co., Ltd. 
--------------------------------
