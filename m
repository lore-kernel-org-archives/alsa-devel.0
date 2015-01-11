From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: ESI  Juli@ crash with external clock switch - patch
Date: Sun, 11 Jan 2015 14:58:12 +0100
Message-ID: <54B28174.7060008@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
 [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id D2C2E2604BF
 for <alsa-devel@alsa-project.org>; Sun, 11 Jan 2015 14:58:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi,

I have investigated a crash/kernel thread lockup when Juli@ is switched 
to external SPDIF clock and the incoming SPDIF stream changes 
samplerate. The problem appears to occur in the timed thread in charge 
of reading incoming samplerate and acting upon its change.

The problem disappears with the following patch:

diff --git a/sound/i2c/other/ak4114.c b/sound/i2c/other/ak4114.c
index c7f5633..68bb326 100644
--- a/sound/i2c/other/ak4114.c
+++ b/sound/i2c/other/ak4114.c
@@ -154,7 +154,7 @@ void snd_ak4114_reinit(struct ak4114 *chip)
  {
         chip->init = 1;
         mb();
-       flush_delayed_work(&chip->work);
+       //flush_delayed_work(&chip->work);
         ak4114_init_regs(chip);
         /* bring up statistics / event queing */
         chip->init = 0;

I am afraid I do not know enough about kernel workqueues to determine 
whether this "fix" is OK.

Interestingly, the almost identical driver ak4113.c for a very similar 
card Infrasonic Quartet (ice1724/quartet.c) does not suffer from this 
problem (tested now).

Thanks a lot for your opinion.

Best regards,

Pavel Hofman.
