From: <twischer@de.adit-jv.com>
Subject: [PATCH] snd_interval_refine_first/last: exclude value
	only if also excluded before
Date: Mon, 2 Jul 2018 16:53:06 +0200
Message-ID: <1530543186-20962-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

Without this commit the following intervals [x y), (x y) were be
replaced to (y-1 y) by snd_interval_refine_last(). This was also done if
y-1 is part of the previous interval.
With this changes it will be replaced with [y-1 y) in case of y-1 is
part of the previous interval. A similar behavior will be used for
snd_interval_refine_first().

This solves the issue reported here:
https://bugzilla.opensuse.org/show_bug.cgi?id=1033179
and work arounded with commit
e736715 ("pcm: dmix: Disable var_periodsize as default").

I am able to reproduce the issue with a simplified aplay use case using
the following configuration:
pcm_slave.adr3_tdm_8ch {
    pcm {
        type hw
        card "Loopback"
        device 0
    }
    rate 48000
    period_size 128
    buffer_size 1024
    channels 2
}

pcm.dshare_Playback_3 {
    type dmix
    ipc_key 600
    ipc_perm 0660
    ipc_gid audio
    var_periodsize true
    slave adr3_tdm_8ch
}

pcm.AdevAcousticoutSpeech {
    type rate
    slave.pcm dshare_Playback_3
    slave.rate 48000
}

$ modprobe snd_aloop
$ aplay -v --period-size=352 -c2 -fS16_LE -r22500 -DAdevAcousticoutSpeech /dev/urandom
...
Rule 9 (0xffff91d1f230): PERIODS=(0 2) -> NONE BUFFER_SIZE=480 PERIOD_SIZE=[240 240]
refine_soft 'AdevAcousticoutSpeech' (end--22)
...
aplay: ../../alsa-utils-1.1.5/aplay/aplay.c:1390: set_params: Assertion `err >= 0' failed.
Aborted by signal Aborted...

The following stack trace shows where the -EINVAL will be thrown:
__snd_pcm_hw_params_set_period_size_near()
snd1_pcm_hw_param_set_near()
snd1_pcm_hw_param_set_last()
snd1_pcm_hw_refine_slave()
snd1_pcm_hw_refine_soft()
snd_pcm_hw_rule_div()
snd1_interval_refine()

This issue exists due to PERIODS does not include 2
Rule 9 (0xffff91d1f230): PERIODS=(0 9) -> (0 2) BUFFER_SIZE=[120 480]
PERIOD_SIZE=(240 241)
because of an invalid integer inverval of PERIOD_SIZE of (240 241).
This interval is set by snd_interval_refine_last().

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
---
 src/pcm/interval.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/src/pcm/interval.c b/src/pcm/interval.c
index 95cedd5..ef4c2ed 100644
--- a/src/pcm/interval.c
+++ b/src/pcm/interval.c
@@ -200,27 +200,33 @@ int snd_interval_refine(snd_interval_t *i, const snd_interval_t *v)
 
 int snd_interval_refine_first(snd_interval_t *i)
 {
+	const unsigned int last_max = i->max;
+
 	if (snd_interval_empty(i))
 		return -ENOENT;
 	if (snd_interval_single(i))
 		return 0;
 	i->max = i->min;
-	i->openmax = i->openmin;
-	if (i->openmax)
+	if (i->openmin)
 		i->max++;
+	/* only exclude max value if also excluded before refine */
+	i->openmax = (i->openmax && i->max >= last_max);
 	return 1;
 }
 
 int snd_interval_refine_last(snd_interval_t *i)
 {
+	const unsigned int last_min = i->min;
+
 	if (snd_interval_empty(i))
 		return -ENOENT;
 	if (snd_interval_single(i))
 		return 0;
 	i->min = i->max;
-	i->openmin = i->openmax;
-	if (i->openmin)
+	if (i->openmax)
 		i->min--;
+	/* only exclude min value if also excluded before refine */
+	i->openmin = (i->openmin && i->min <= last_min);
 	return 1;
 }
 
-- 
2.7.4
