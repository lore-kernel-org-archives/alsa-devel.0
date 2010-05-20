From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Subject: [PATCH 0/2] Correct widget and PLL handling
Date: Thu, 20 May 2010 17:53:06 -0500
Message-ID: <1274395988-19801-1-git-send-email-jorge.candelaria@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id DDC77103815
	for <alsa-devel@alsa-project.org>;
	Fri, 21 May 2010 01:05:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Fix an issue when using 19.2 Mhz as clock input for TWL6040.

Also, Drivers in TWL6040 can be modeled after PGA components of DAPM.
This allows for better power management and also ensures that
the DACs are enabled before the Drivers, reducing this way a
pop-noise heard when powering up components.
