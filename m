From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 1/3] topology: Fix missing stream name of
	widgets in text conf file
Date: Thu, 20 Oct 2016 13:48:27 +0800
Message-ID: <ee4f92404be88a9d0a97df121b021e0b9d2054ad.1476941614.git.mengdong.lin@linux.intel.com>
References: <cover.1476941614.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A24842666CF
 for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2016 07:47:24 +0200 (CEST)
In-Reply-To: <cover.1476941614.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

User can define the stream name of an input/output widget in the text conf
file, by setting "stream_name" of a SectionWidget.

Topology C API and kernel already have support for configuring a widget's
stream name. This patch just adds the missing part of the text conf file.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index 0675b52..a0d018e 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -483,6 +483,7 @@ extern "C" {
  *	index "1"			# Index number
  *
  *	type "aif_in"			# Widget type - detailed above
+ *	stream_name "name"		# Stream name
  *
  *	no_pm "true"			# No PM control bit.
  *	reg "20"			# PM bit register offset
diff --git a/src/topology/dapm.c b/src/topology/dapm.c
index e3c90d8..9fa0aac 100644
--- a/src/topology/dapm.c
+++ b/src/topology/dapm.c
@@ -507,6 +507,16 @@ int tplg_parse_dapm_widget(snd_tplg_t *tplg,
 			continue;
 		}
 
+		if (strcmp(id, "stream_name") == 0) {
+			if (snd_config_get_string(n, &val) < 0)
+				return -EINVAL;
+
+			elem_copy_text(widget->sname, val,
+				       SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+			tplg_dbg("\t%s: %s\n", id, val);
+			continue;
+		}
+
 		if (strcmp(id, "no_pm") == 0) {
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
-- 
2.5.0
