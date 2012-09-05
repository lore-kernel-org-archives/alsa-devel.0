From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: compress_core: integer overflow in
 snd_compr_allocate_buffer()
Date: Wed, 5 Sep 2012 15:32:18 +0300
Message-ID: <20120905123217.GD6128@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from acsinet15.oracle.com (acsinet15.oracle.com [141.146.126.227])
 by alsa0.perex.cz (Postfix) with ESMTP id A9C18265347
 for <alsa-devel@alsa-project.org>; Wed,  5 Sep 2012 14:32:28 +0200 (CEST)
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
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jesper Juhl <jj@chaosbits.net>, Namarta Kohli <namartax.kohli@intel.com>
List-Id: alsa-devel@alsa-project.org

These are 32 bit values that come from the user, we need to check for
integer overflows or we could end up allocating a smaller buffer than
expected.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index ec2118d..5a733e7 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -409,6 +409,10 @@ static int snd_compr_allocate_buffer(struct snd_compr_stream *stream,
 	unsigned int buffer_size;
 	void *buffer;
 
+	if (params->buffer.fragment_size == 0 ||
+	    params->buffer.fragments > SIZE_MAX / params->buffer.fragment_size)
+		return -EINVAL;
+
 	buffer_size = params->buffer.fragment_size * params->buffer.fragments;
 	if (stream->ops->copy) {
 		buffer = NULL;
