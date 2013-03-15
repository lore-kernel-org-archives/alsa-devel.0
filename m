From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] sound: sequencer: cap array index in
	seq_chn_common_event()
Date: Fri, 15 Mar 2013 09:14:22 +0300
Message-ID: <20130315061422.GB3793@longonot.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 220CF26171B
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2013 07:15:56 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

"chn" here is a number between 0 and 255, but ->chn_info[] only has
16 elements so there is a potential write beyond the end of the
array.

If the seq_mode isn't SEQ_2 then we let the individual drivers
(either opl3.c or midi_synth.c) handle it.  Those functions all
do a bounds check on "chn" so I haven't changed anything here.
The opl3.c driver has up to 18 channels and not 16.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Static checker stuff.

diff --git a/sound/oss/sequencer.c b/sound/oss/sequencer.c
index 30bcfe4..4ff60a6 100644
--- a/sound/oss/sequencer.c
+++ b/sound/oss/sequencer.c
@@ -545,6 +545,9 @@ static void seq_chn_common_event(unsigned char *event_rec)
 		case MIDI_PGM_CHANGE:
 			if (seq_mode == SEQ_2)
 			{
+				if (chn > 15)
+					break;
+
 				synth_devs[dev]->chn_info[chn].pgm_num = p1;
 				if ((int) dev >= num_synths)
 					synth_devs[dev]->set_instr(dev, chn, p1);
@@ -596,6 +599,9 @@ static void seq_chn_common_event(unsigned char *event_rec)
 		case MIDI_PITCH_BEND:
 			if (seq_mode == SEQ_2)
 			{
+				if (chn > 15)
+					break;
+
 				synth_devs[dev]->chn_info[chn].bender_value = w14;
 
 				if ((int) dev < num_synths)
