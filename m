From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 3/7] topology: Add doc for vendor tuples
Date: Wed, 30 Mar 2016 15:10:52 +0800
Message-ID: <bbec90cdc53fe084b53d57b07614604a4eb05901.1459321387.git.mengdong.lin@linux.intel.com>
References: <cover.1459321387.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 95ACB2605C3
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 09:08:47 +0200 (CEST)
In-Reply-To: <cover.1459321387.git.mengdong.lin@linux.intel.com>
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

Describe how to define vendor tokens and tuples in the text conf file.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index 011f6ae..51d282f 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -203,12 +203,77 @@ extern "C" {
  *	bytes "0x12,0x34,0x56,0x78"
  *	shorts "0x1122,0x3344,0x5566,0x7788"
  *	words "0xaabbccdd,0x11223344,0x66aa77bb,0xefef1234"
+ *	tuples "section id of the vendor tuples"
  * };
  * </pre>
- * The file, bytes, shorts and words keywords are all mutually exclusive as
- * the private data should only be taken from one source.  The private data can
- * either be read from a separate file or defined in the topology file using
- * the bytes, shorts or words keywords.
+ * The file, bytes, shorts, words and tuples keywords are all mutually
+ * exclusive as the private data should only be taken from one source.
+ * The private data can either be read from a separate file or defined in
+ * the topology file using the bytes, shorts, words or tuples keywords.
+ * The keyword tuples is to define vendor specific tuples. Please refer to
+ * section Vendor Tokens and Vendor tuples.
+ *
+ *  <h6>Vendor Tokens</h6>
+ * A vendor token list is defined as a new section. Each token element is
+ * a pair of string ID and integer value. And both the ID and value are
+ * vendor-specific.
+ *
+ * <pre>
+ * SectionVendorTokens."id of the vendor tokens" {
+ *	comment "optional comments"
+ *	VENDOR_TOKEN_ID1 "1"
+ *	VENDOR_TOKEN_ID2 "2"
+ *	VENDOR_TOKEN_ID3 "3"
+ *	...
+ * }
+ * </pre>
+ *
+ *  <h6>Vendor Tuples</h6>
+ * Vendor tuples are defined as a new section. It contains a reference to
+ * a vendor token list and several tuple arrays.
+ * All arrays share a vendor token list, defined by the tokens keyword.
+ * Each tuple array is for a specific type, defined by the string following
+ * the tuples keyword. Supported types are: string, uuid, bool, byte,
+ * short and word.
+ *
+ * <pre>
+ * SectionVendorTuples."id of the vendor tuples" {
+ *	tokens "id of the vendor tokens"
+ *
+ *	tuples."string" {
+ *		VENDOR_TOKEN_ID1 "character string"
+ *		...
+ *	}
+ *
+ *	tuples."uuid" {
+ *		VENDOR_TOKEN_ID2 "16 character uuid"
+ *		...
+ *	}
+ *
+ *	tuples."bool" {
+ *		VENDOR_TOKEN_ID3 "true/false"
+ *		...
+ *	}
+ *
+ *	tuples."byte" {
+ *		VENDOR_TOKEN_ID4 "0x11"
+ *		VENDOR_TOKEN_ID5 "0x22"
+ *		...
+ *	}
+ *
+ *	tuples."short" {
+ *		VENDOR_TOKEN_ID6 "0x1122"
+ *		VENDOR_TOKEN_ID7 "0x3344"
+ *		...
+ *	}
+ *
+ *	tuples."word" {
+ *		VENDOR_TOKEN_ID8 "0x11223344"
+ *		VENDOR_TOKEN_ID9 "0x55667788"
+ *		...
+ *	}
+ * }
+ * </pre>
  *
  * <h5>Mixer Controls</h5>
  * A mixer control is defined as a new section that can include channel mapping,
@@ -389,6 +454,10 @@ extern "C" {
  * fields are the same for widgets as they are for controls whilst the other
  * fields map on very closely to the driver widget fields.
  *
+ * <h5>Widget Private Data</h5>
+ * Widget can have private data. For the format of the private data, please
+ * refer to section Control Private Data.
+ *
  * <h4>PCM Capabilities</h4>
  * Topology can also define the capabilities of FE and BE PCMs. Capabilities
  * can be defined with the following section :-
-- 
2.5.0
