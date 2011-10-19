From: Julian Scheel <julian@jusst.de>
Subject: tegra_wm8903 dapm_nc_pins
Date: Wed, 19 Oct 2011 17:29:09 +0200
Message-ID: <1319038149.1720.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.work.de (smtp1.work.de [212.12.40.178])
	by alsa0.perex.cz (Postfix) with ESMTP id BAF12245FE
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Oct 2011 17:29:10 +0200 (CEST)
Received: from [84.142.21.107] (helo=[172.20.31.156])
	by smtp1.work.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72) (envelope-from <julian@jusst.de>) id 1RGY4r-00075e-Hg
	for alsa-devel@alsa-project.org; Wed, 19 Oct 2011 15:29:09 +0000
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
List-Id: alsa-devel@alsa-project.org

Hi,

is there any special reason for the dapm_nc_pins being hardcoded into
tegra_wm8903.c instead of being set through the platform data?
We are currently making up a platform setting for our devices and would
like to have all relevant settings within the platform driver instead of
having to hack the tegra_wm8903-driver with further machine_is_XX()
checks.

So I would suggest to add an entry to the platform data which contains a
list of NC-pins which are then set to nc by the tegra_wm8903 driver on
startup.

Regards,
Julian
