From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: [PATCH 0/2] Add Voice Codec support for DaVinci
	platforms
Date: Thu, 07 Jan 2010 16:16:37 -0600
Message-ID: <4B465D45.40401@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 8640E24426
	for <alsa-devel@alsa-project.org>; Thu,  7 Jan 2010 23:17:06 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Mark Brown <broonie@o>
Cc: "Nori, Sekhar" <nsekhar@ti.com>, "Narnakaje,
	Snehaprabha" <nsnehaprabha@ti.com>, Diego Dompe <diego.dompe@ridgerun.com>, todd Fischer <todd.fischer@ridgerun.com>
List-Id: alsa-devel@alsa-project.org

Hi,

The following patch series adds support for the Voice Codec in the Davinci 
platform and in this particular case for the DM365 EVM.

The second patch of the series configures the DM365 EVM sound card with two audi 
subdevices the AIC3x codec and the voice codec. The voice codec driver was 
tested on the DM365 EVM, however when the AIC and Voice Codec are defined as 
subdevices of the sound card doesn't work properly, so please check the file 
sound/soc/davinci/davinci-evm.c.

Thanks,
-- 
Miguel Angel Aguilar Ulloa
Embedded Software Engineer
RidgeRun Embedded Solutions
miguel.aguilar@ridgerun.com
