From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: ABI - Define types for vendor
	tuples" to the asoc tree
Date: Tue, 29 Mar 2016 11:44:58 -0700
Message-ID: <E1akydO-00033O-NI@finisterre>
References: <1458787994-28260-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E81DF266267
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 20:45:07 +0200 (CEST)
In-Reply-To: <1458787994-28260-1-git-send-email-mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: ABI - Define types for vendor tuples

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e42839b012eb8179ed2e3571bfcd133fba5df154 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Thu, 24 Mar 2016 10:53:14 +0800
Subject: [PATCH] ASoC: topology: ABI - Define types for vendor tuples

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/asoc.h | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index c4cc1e40b35c..db86b447b515 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -116,6 +116,14 @@
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
@@ -132,6 +140,35 @@ struct snd_soc_tplg_hdr {
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
@@ -139,7 +176,10 @@ struct snd_soc_tplg_hdr {
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
2.8.0.rc3
