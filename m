From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: [PATCH 0/5] Add Voice Codec support for DaVinci
	platforms
Date: Thu, 21 Jan 2010 11:35:10 -0600
Message-ID: <4B58904E.4030108@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 3DD151037F5
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 18:38:36 +0100 (CET)
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
Cc: clarkbecker <clark.becker@ridgerun.com>, Santiago Nunez <santiago.nunez@ridgerun.com>, Diego Dompe <diego.dompe@ridgerun.com>, "Nori,
	Sekhar" <nsekhar@ti.com>, "Narnakaje, Snehaprabha" <nsnehaprabha@ti.com>, Todd Fischer <todd.fischer@ridgerun.com>
List-Id: alsa-devel@alsa-project.org

Hi,

The following patch series adds support for the Voice Codec in the Davinci 
platform and in this particular case for the DM365 EVM.

The DM365 EVM has two codecs the AIC3x and the Voice Codec, however at this 
point is not possible to have both enabled simultaneously since the soc-core 
doesn't support that, so a patch for enable both simultaneously will be sent 
when this support is available in the soc-core.

Regards,

-- 
Miguel Angel Aguilar Ulloa
Embedded Software Engineer
RidgeRun Embedded Solutions
miguel.aguilar@ridgerun.com
