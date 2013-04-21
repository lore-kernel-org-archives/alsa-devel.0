From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: compress: info leak in
	snd_compr_get_caps()
Date: Sun, 21 Apr 2013 14:07:29 +0300
Message-ID: <20130421110729.GA6171@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 8175026007E
 for <alsa-devel@alsa-project.org>; Sun, 21 Apr 2013 13:07:36 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Namarta Kohli <namartax.kohli@intel.com>
List-Id: alsa-devel@alsa-project.org

If the ->get_caps() function doesn't clear the buffer then there would
stack information leaked to userspace.  For example,
soc_compr_get_caps() can return success without clearing the buffer.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Perhaps the soc_compr_get_caps() function should return an error code
if the platform->driver->compr_ops is NULL.  I'm not sure about that,
and it's a separate issue anyway.

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index c84abc8..8d3190a 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -375,6 +375,7 @@ snd_compr_get_caps(struct snd_compr_stream *stream, unsigned long arg)
 	if (!stream->ops->get_caps)
 		return -ENXIO;
 
+	memset(&caps, 0, sizeof(caps));
 	retval = stream->ops->get_caps(stream, &caps);
 	if (retval)
 		goto out;
