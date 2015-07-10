From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Cannot open shared
	library	/usr/lib/alsa-lib/libasound_module_pcm_jack.so
Date: Fri, 10 Jul 2015 08:38:53 +0200
Message-ID: <559F687D.3040305@ladisch.de>
References: <SIXPR04MB25362E92C1A38365A48DF57C3900@SIXPR04MB253.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 4BE1526042B
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 08:38:55 +0200 (CEST)
Received: from [10.1.2.65] (unknown [94.101.37.4])
 by dehamd003.servertools24.de (Postfix) with ESMTPSA id A2C63F520032
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 08:38:54 +0200 (CEST)
In-Reply-To: <SIXPR04MB25362E92C1A38365A48DF57C3900@SIXPR04MB253.apcprd04.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Srinivasan S wrote:
> ...
> checking for pkg-config... /opt/ti-sdk-am335x-evm-07.00.00.00/linux-devkit/sysroots/i686-arago-linux/usr/bin//pkg-config
> checking pkg-config is at least version 0.9.0... yes
> checking for ALSA... no
> configure: error: Package requirements (alsa >= 1.0.11) were not met:

Well, did you cross-compile alsa-lib?


Regards,
Clemens
