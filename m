From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] MAINTAINERS: Add maintainer for Analog Devices
	sound CODECs
Date: Mon, 17 Oct 2011 20:33:05 +0200
Message-ID: <1318876385-26902-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-020.synserver.de
	[212.40.185.20]) by alsa0.perex.cz (Postfix) with SMTP id 9CC7D245E2
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Oct 2011 20:33:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: drivers@analog.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <michael.hennerich@analog.com>, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

The MAINTAINERS  entry for the ADI sound CODEC drivers currently only lists the
ADI devices-drivers-devel mailing-list. Add myself as additional contact, since
I'm the person at ADI who is currently doing most of the work on these drivers.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 MAINTAINERS |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0b4ccdd..b2dabb7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -530,6 +530,7 @@ S:	Maintained
 F:	drivers/infiniband/hw/amso1100/
 
 ANALOG DEVICES INC ASOC CODEC DRIVERS
+M:	Lars-Peter Clausen <lars@metafoo.de>
 L:	device-drivers-devel@blackfin.uclinux.org
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 W:	http://wiki.analog.com/
-- 
1.7.2.5
