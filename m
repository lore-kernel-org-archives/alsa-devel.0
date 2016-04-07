From: mengdong.lin@linux.intel.com
Subject: [PATCH v3 4/7] topology: ABI - Define types for vendor
	tuples
Date: Thu,  7 Apr 2016 15:29:27 +0800
Message-ID: <a75bdfc07ce0be766e1f5b8516cd02e921d0d138.1460013338.git.mengdong.lin@linux.intel.com>
References: <cover.1460013338.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C268F2661A1
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 09:27:04 +0200 (CEST)
In-Reply-To: <cover.1460013338.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, liam.r.girdwood@intel.com, hardik.t.shah@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Tuples, a pair of token and value, can be used to define vendor specific
data, for controls and widgets. This can avoid importing binary data blob
from other files.

Vendor specific tuple arrays will be embeded in the private data buffer
of a control or widget object. To be backward compatible, union is used
to define the tuple arrays in the existing private data ABI object
'struct snd_soc_tplg_private'.

Vendors need to make sure the token values defined by the topology conf
file match those defined by their driver.

Now supported tuple types are uuid, string, bool, byte, short and word.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index a29c05c..920c9e0 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -107,6 +107,14 @@
 #define SND_SOC_TPLG_STREAM_PLAYBACK	0
 #define SND_SOC_TPLG_STREAM_CAPTURE	1
 
+/* vendor tuple types */
+#define SND_SOC_TPLG_TUPLE_TYPE_UUID	0
+#define SND_SOC_TPLG_TUPLE_TYPE_STRING	1
+#define SND_SOC_TPLG_TUPLE_TYPE_BOOL	2
+#define SND_SOC_TPLG_TUPLE_TYPE_BYTE	3
+#define SND_SOC_TPLG_TUPLE_TYPE_WORD	4
+#define SND_SOC_TPLG_TUPLE_TYPE_SHORT	5
+
 /*
  * Block Header.
  * This header precedes all object and object arrays below.
@@ -123,6 +131,35 @@ struct snd_soc_tplg_hdr {
 	__le32 count;		/* number of elements in block */
 } __attribute__((packed));
 
+/* vendor tuple for uuid */
+struct snd_soc_tplg_vendor_uuid_elem {
+	__le32 token;
+	char uuid[16];
+} __attribute__((packed));
+
+/* vendor tuple for a bool/byte/short/word value */
+struct snd_soc_tplg_vendor_value_elem {
+	__le32 token;
+	__le32 value;
+} __attribute__((packed));
+
+/* vendor tuple for string */
+struct snd_soc_tplg_vendor_string_elem {
+	__le32 token;
+	char string[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+} __attribute__((packed));
+
+struct snd_soc_tplg_vendor_array {
+	__le32 size;	/* size in bytes of the array, including all elements */
+	__le32 type;	/* SND_SOC_TPLG_TUPLE_TYPE_ */
+	__le32 num_elems;	/* number of elements in array */
+	union {
+		struct snd_soc_tplg_vendor_uuid_elem uuid[0];
+		struct snd_soc_tplg_vendor_value_elem value[0];
+		struct snd_soc_tplg_vendor_string_elem string[0];
+	};
+} __attribute__((packed));
+
 /*
  * Private data.
  * All topology objects may have private data that can be used by the driver or
@@ -130,7 +167,10 @@ struct snd_soc_tplg_hdr {
  */
 struct snd_soc_tplg_private {
 	__le32 size;	/* in bytes of private data */
-	char data[0];
+	union {
+		char data[0];
+		struct snd_soc_tplg_vendor_array array[0];
+	};
 } __attribute__((packed));
 
 /*
-- 
2.5.0
