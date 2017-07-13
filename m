From: ? ? <wangkuisuper@hotmail.com>
Subject: [PATCH - pulse 1/1] pulse: prevent double-free when
 pulse_hw_constraint returns error
Date: Thu, 13 Jul 2017 19:33:05 +0000
Message-ID: <HK2PR0201MB22109F1527B9D0C04BF5C1AFC6AC0@HK2PR0201MB2210.apcprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "patch@alsa-project.org" <patch@alsa-project.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ? ? <wangkuisuper@hotmail.com>
List-Id: alsa-devel@alsa-project.org

From: Kui Wang <wangkuisuper@hotmail.com>

When pulse_hw_constraint returns error, snd_pcm_ioplug_delete() is called.
It will then call pulse_close() where "snd_pcm_pulse_t *pcm" will be free.
Then if goto the "error" label, the "snd_pcm_pulse_t *pcm" will be double-free.

To prevent this, just jump over the code which might cause double-free.

Signed-off-by: Kui Wang <wangkuisuper@hotmail.com>

diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
index 5cb3452..a8983c6 100644
--- a/pulse/pcm_pulse.c
+++ b/pulse/pcm_pulse.c
@@ -1143,7 +1143,7 @@ SND_PCM_PLUGIN_DEFINE_FUNC(pulse)
 	err = pulse_hw_constraint(pcm);
 	if (err < 0) {
 		snd_pcm_ioplug_delete(&pcm->io);
-		goto error;
+		goto error2;
 	}
 
 	*pcmp = pcm->io.pcm;
@@ -1156,6 +1156,7 @@ error:
 	free(pcm->device);
 	free(pcm);
 
+error2:
 	if (fallback_name)
 		return snd_pcm_open_fallback(pcmp, root, fallback_name, name,
 					     stream, mode);
-- 
2.13.2.windows.1
