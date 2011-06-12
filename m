From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/3] ALSA: hdspm - Fix locking in
	snd_hdspm_midi_input_read
Date: Sun, 12 Jun 2011 17:26:17 +0200
Message-ID: <1307892379-31179-2-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1307892379-31179-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1307892379-31179-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

For the MIDI part, we need to acquire (and release) the hmidi->lock,
access to the global hdspm structure is serialized through
hmidi->hdspm->lock instead.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 949691a..32d80af 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1639,12 +1639,14 @@ static int snd_hdspm_midi_input_read (struct hdspm_midi *hmidi)
 		}
 	}
 	hmidi->pending = 0;
+	spin_unlock_irqrestore(&hmidi->lock, flags);
 
+	spin_lock_irqsave(&hmidi->hdspm->lock, flags);
 	hmidi->hdspm->control_register |= hmidi->ie;
 	hdspm_write(hmidi->hdspm, HDSPM_controlRegister,
 		    hmidi->hdspm->control_register);
+	spin_unlock_irqrestore(&hmidi->hdspm->lock, flags);
 
-	spin_unlock_irqrestore (&hmidi->lock, flags);
 	return snd_hdspm_midi_output_write (hmidi);
 }
 
-- 
1.7.5.4
