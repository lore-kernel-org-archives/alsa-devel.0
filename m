From: srinivas.kandagatla@linaro.org
Subject: [PATCH v10 13/13] MAINTAINERS: Add SLIMbus maintainer
Date: Mon, 11 Dec 2017 23:43:07 +0000
Message-ID: <20171211234307.14465-14-srinivas.kandagatla@linaro.org>
References: <20171211234307.14465-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20171211234307.14465-1-srinivas.kandagatla@linaro.org>
Sender: linux-doc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org
Cc: sdharia@codeaurora.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, pombredanne@nexb.com, j.neuschaefer@gmx.net, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

