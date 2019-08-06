From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 08/17] soundwire: stream: fix disable sequence
Date: Mon,  5 Aug 2019 19:55:13 -0500
Message-ID: <20190806005522.22642-9-pierre-louis.bossart@linux.intel.com>
References: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, Blauciak@vger.kernel.org, Slawomir <slawomir.blauciak@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

When we disable the stream and then call hw_free, two bank switches
will be handled and as a result we re-enable the stream on hw_free.

Make sure the stream is disabled on both banks.

TODO: we need to completely revisit all this and make sure we have a
mirroring mechanism between current and alternate banks.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/stream.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 53f5e790fcd7..75b9ad1fb1a6 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1637,7 +1637,24 @@ static int _sdw_disable_stream(struct sdw_stream_runtime *stream)
 		}
 	}
 
-	return do_bank_switch(stream);
+	ret = do_bank_switch(stream);
+	if (ret < 0) {
+		dev_err(bus->dev, "Bank switch failed: %d\n", ret);
+		return ret;
+	}
+
+	/* make sure alternate bank (previous current) is also disabled */
+	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
+		bus = m_rt->bus;
+		/* Disable port(s) */
+		ret = sdw_enable_disable_ports(m_rt, false);
+		if (ret < 0) {
+			dev_err(bus->dev, "Disable port(s) failed: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
 }
 
 /**
-- 
2.20.1
