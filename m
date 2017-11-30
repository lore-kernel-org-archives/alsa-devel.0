From: srinivas.kandagatla@linaro.org
Subject: [PATCH v8 13/13] MAINTAINERS: Add SLIMbus maintainer
Date: Thu, 30 Nov 2017 17:42:00 +0000
Message-ID: <20171130174200.6684-14-srinivas.kandagatla@linaro.org>
References: <20171130174200.6684-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171130174200.6684-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, vinod.koul@intel.com, arnd@arndb.de, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Add myself as maintainer for slimbus.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa71ab52fd76..f26bf2707709 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12500,6 +12500,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
 F:	include/linux/srcu.h
 F:	kernel/rcu/srcu.c
 
+SERIAL LOW-POWER INTER-CHIP MEDIA BUS (SLIMbus)
+M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/slimbus/
+F:	Documentation/devicetree/bindings/slimbus/
+F:	include/linux/slimbus.h
+
 SMACK SECURITY MODULE
 M:	Casey Schaufler <casey@schaufler-ca.com>
 L:	linux-security-module@vger.kernel.org
-- 
2.15.0
