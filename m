From: mengdong.lin@linux.intel.com
Subject: [PATCH v4 3/3] topology: Add doc for including other
	files in the text conf file
Date: Mon, 24 Oct 2016 21:22:19 +0800
Message-ID: <6cc1f68b2d71bacaaca9ac5b5226fca59da161bb.1477315063.git.mengdong.lin@linux.intel.com>
References: <cover.1477315063.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id BE4F8266C10
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 15:21:10 +0200 (CEST)
In-Reply-To: <cover.1477315063.git.mengdong.lin@linux.intel.com>
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

This patch adds document about how to include other files in the text
configuration files, by alsaconf syntax <xxx> and <searchdir:xxx>.

Users may define common info in separate files (e.g. vendor tokens,
tuples) and share them for different platforms, by including them via
syntax <path/to/configuration-file>. This can save the total size of
files. Users can also specifiy additional configuraiton directories
relative to "/usr/share/alsa/" to search the included files, via syntax
<searchdir:relative-path/to/usr/share/alsa>.

The alsaconf will search and open an included file in the following order
of priority:
1. directly open the file by its name;
2. search for the file name in "/usr/share/alsa";
3. search for the file name in user specified subdirectories under
   "/usr/share/alsa".

The order of the included files need not to be same as their dependencies,
because the toplogy library will load all of them before parsing their
dependencies.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index a0d018e..4f606c7 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -624,6 +624,36 @@ extern "C" {
  *	data "name"			# optional private data
  * }
  * </pre>
+ *
+ * <h4>Include other files</h4>
+ * Users may include other files in a text conf file via alsaconf syntax
+ * <path/to/configuration-file>. This allows users to define common info
+ * in separate files (e.g. vendor tokens, tuples) and share them for
+ * different platforms, thus save the total size of config files. <br>
+ * Users can also specifiy additional configuraiton directories relative
+ * to "/usr/share/alsa/" to search the included files,  via alsaconf syntax
+ * <searchfdir:/relative-path/to/usr/share/alsa>. <br><br>
+ *
+ * For example, file A and file B are two text conf files for platform X,
+ * they will be installed to /usr/share/alsa/topology/platformx. If we
+ * need file A to include file B, in file A we can add: <br>
+ *
+ * <searchdir:topology/platformx> <br>
+ * <name-of-file-B> <br><br>
+ *
+ * ALSA conf will search and open an included file in the following order
+ * of priority:
+ *  1. directly open the file by its name;
+ *  2. search for the file name in "/usr/share/alsa";
+ *  3. search for the file name in user specified subdirectories under
+ *     "/usr/share/alsa".
+ *
+ * The order of the included files need not to be same as their
+ * dependencies, since the topology library will load them all before
+ * parsing their dependencies. <br>
+ *
+ * The configuration directories defined by a file will only be used to search
+ * the files included by this file.
  */
 
 /** Maximum number of channels supported in one control */
-- 
2.5.0
