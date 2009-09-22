From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: [PATCH 0/4] Add Voice Codec support for DM365
Date: Tue, 22 Sep 2009 13:28:46 -0600
Message-ID: <4AB9256E.6050602@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id C5F8A1037F2
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Sep 2009 21:28:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Narnakaje, Snehaprab
List-Id: alsa-devel@alsa-project.org

Hi,

The following series of patches adds the following support:

1) CQ0093 Voice Codec driver.
2) Voice Codec Interface.
3) Voice Codec resources and Voice Codec Interface platform device.
4) Voice Codec on the DM365 EVM.

Notes:

The patch series was created based on the current temp/asoc branch of the 
DaVinci git.

It assumes that the patch "[PATCH v4 2/2] ASoC: Davinci: Add audio codec support 
for DM365 EVM" is applied.

This patch series was tested on a DM365 EVM rev C.

Regards,

-- 
Miguel Angel Aguilar Ulloa
Embedded Software Engineer
RidgeRun Embedded Solutions
miguel.aguilar@ridgerun.com
