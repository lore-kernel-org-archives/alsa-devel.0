From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: Intel: some incorrect sizeof() usages
Date: Wed, 16 Apr 2014 18:38:11 +0300
Message-ID: <20140416153811.GB16325@mwanda>
References: <20140413195636.32f31cb2@spike>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140413195636.32f31cb2@spike>
Sender: kernel-janitors-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Christian Engelmayer <cengelma@gmx.at>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The intent was to say "sizeof(*pos)" and not "sizeof(pos)".

The sizeof(*pos) is 8 bytes so the bug won't show up on 64 bit systems.
The sizeof(*dx) is 172 bytes so that will be a bugfix.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Static analysis.  Not tested.

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index f46bb4d..4ed2d17 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -617,7 +617,7 @@ static void hsw_notification_work(struct work_struct *work)
 	case IPC_POSITION_CHANGED:
 		trace_ipc_notification("DSP stream position changed for",
 			stream->reply.stream_hw_id);
-		sst_dsp_inbox_read(hsw->dsp, pos, sizeof(pos));
+		sst_dsp_inbox_read(hsw->dsp, pos, sizeof(*pos));
 
 		if (stream->notify_position)
 			stream->notify_position(stream, stream->pdata);
@@ -1609,7 +1609,7 @@ int sst_hsw_dx_set_state(struct sst_hsw *hsw,
 	trace_ipc_request("PM enter Dx state", state);
 
 	ret = ipc_tx_message_wait(hsw, header, &state_, sizeof(state_),
-		dx, sizeof(dx));
+		dx, sizeof(*dx));
 	if (ret < 0) {
 		dev_err(hsw->dev, "ipc: error set dx state %d failed\n", state);
 		return ret;
