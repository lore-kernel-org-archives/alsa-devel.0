From: Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH 01/11] MAINTANERS: Add AXD as a supported driver
Date: Tue, 28 Oct 2014 11:26:19 +0000
Message-ID: <1414495589-8579-2-git-send-email-qais.yousef@imgtec.com>
References: <1414495589-8579-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414495589-8579-1-git-send-email-qais.yousef@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Qais Yousef <qais.yousef@imgtec.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

AXD is Audio Processing IP driver that will be added in the following commits

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <alsa-devel@alsa-project.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dab92a78d1d5..b42c7386190e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1826,6 +1826,12 @@ F:	include/uapi/linux/ax25.h
 F:	include/net/ax25.h
 F:	net/ax25/
 
+AXD AUDIO PROCESSING IP DRIVER
+M:	Qais Yousef <qais.yousef@imgtec.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/axd.txt
+F:	drivers/char/axd/
+
 AZ6007 DVB DRIVER
 M:	Mauro Carvalho Chehab <m.chehab@samsung.com>
 L:	linux-media@vger.kernel.org
-- 
2.1.0
