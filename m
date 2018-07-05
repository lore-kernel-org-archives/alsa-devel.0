From: Shreyas NC <shreyas.nc@intel.com>
Subject: [PATCH v5 2/9] soundwire: fix incorrect exit after
	configuring stream
Date: Thu,  5 Jul 2018 17:16:29 +0530
Message-ID: <1530791196-15483-3-git-send-email-shreyas.nc@intel.com>
References: <1530791196-15483-1-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id BA737267650
 for <alsa-devel@alsa-project.org>; Thu,  5 Jul 2018 13:48:30 +0200 (CEST)
In-Reply-To: <1530791196-15483-1-git-send-email-shreyas.nc@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: patches.audio@intel.com, gregkh@linuxfoundation.org, pierre-louis.bossart@linux.intel.com, vkoul@kernel.org, Shreyas NC <shreyas.nc@intel.com>, sanyog.r.kale@intel.com
List-Id: alsa-devel@alsa-project.org

In sdw_stream_add_master() after the Master ports are configured,
the stream is released incorrectly.

So, fix it by avoiding stream release after configuring the Master
for the stream.
While at it, rename the label appropriately.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
---
 drivers/soundwire/stream.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 37603c3..5871594 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1112,7 +1112,7 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 				"Master runtime config failed for stream:%s",
 				stream->name);
 		ret = -ENOMEM;
-		goto error;
+		goto unlock;
 	}
 
 	ret = sdw_config_stream(bus->dev, stream, stream_config, false);
@@ -1123,9 +1123,11 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 	if (ret)
 		goto stream_error;
 
+	goto unlock;
+
 stream_error:
 	sdw_release_master_stream(stream);
-error:
+unlock:
 	mutex_unlock(&bus->bus_lock);
 	return ret;
 }
-- 
2.7.4
