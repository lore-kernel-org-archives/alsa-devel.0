From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] slimbus: stream: Fix htmldocs warnings
Date: Sat,  7 Jul 2018 20:28:41 +0100
Message-ID: <20180707192841.2358-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch fixes below warning during building htmldoc:
slimbus.h:352: warning: Function parameter or member 'name'
 not described in 'slim_stream_runtime'

This patch also removes documentation for state variable
in struct slim_stream_runtime which was redundant and removed.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/slimbus.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
index 411880f3fc0a..32ac4046154f 100644
--- a/drivers/slimbus/slimbus.h
+++ b/drivers/slimbus/slimbus.h
@@ -325,9 +325,8 @@ enum slim_transport_protocol {
 /**
  * struct slim_stream_runtime  - SLIMbus stream runtime instance
  *
- * @dev: Name of the stream
+ * @name: Name of the stream
  * @dev: SLIM Device instance associated with this stream
- * @state: state of stream
  * @direction: direction of stream
  * @prot: Transport protocol used in this stream
  * @rate: Data rate of samples *
-- 
2.16.2
