From: "Ghadiya, Anil" <Anil.Ghadiya@analog.com>
Subject: ASoC Machine driver
Date: Thu, 15 Jan 2015 10:50:13 +0000
Message-ID: <3CBA22CF300FD249BCB6F384EAF3E95C0CE4F261@NWD2MBX5.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0069.outbound.protection.outlook.com [157.56.111.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 225D326046B
 for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2015 11:51:29 +0100 (CET)
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com
 [10.64.72.141])
 by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id t0FAojXB030334
 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
 for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2015 02:50:45 -0800
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi All,

I am new to ALSA architecture and want to understand the flow of the driver. So I took one of the existing codec driver "adau1701" and build it for the my imx6q-sabrelite development board. I am able to build and insert it on the board. Now I want to write ASoC machine driver for the same. I am hoping that I do not need to write ASoC platform driver as my codec is not using any I2S, DMA, S/PDIF or any SOC specific driver.

I have seen the machine driver for other platform. I can see that sound card is getting registered in the probe function of the machine driver, but . I am not able to understand the flow here.

Could you please help me understand the flow of execution like........
when probe function of machine driver gets called?
When will the probe function od codec driver gets executed? and so on....

Thanks in Advance,
Anil Patel
