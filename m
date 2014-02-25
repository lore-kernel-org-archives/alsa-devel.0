From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 2/2] ASoC: sst-haswell-ipc: incorrect sizeof()
Date: Tue, 25 Feb 2014 11:33:44 +0300
Message-ID: <20140225083343.GB22416@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This should be sizeof(pos) instead of sizeof(&pos).  Most likely they
are both 8 bytes though so it doesn't often make a difference in real
life.

Fixes: 22981243589c ('ASoC: Intel: Add Haswell/Broadwell IPC')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 552aebf2c8f5..1f1576a9586a 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -617,7 +617,7 @@ static void hsw_notification_work(struct work_struct *work)
 	case IPC_POSITION_CHANGED:
 		trace_ipc_notification("DSP stream position changed for",
 			stream->reply.stream_hw_id);
-		sst_dsp_inbox_read(hsw->dsp, pos, sizeof(&pos));
+		sst_dsp_inbox_read(hsw->dsp, pos, sizeof(pos));
 
 		if (stream->notify_position)
 			stream->notify_position(stream, stream->pdata);
