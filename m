From: Abhilash Jindal <klock.android@gmail.com>
Subject: ALSA: es1968: Use monotonic clock
Date: Sat, 8 Aug 2015 21:48:23 -0400
Message-ID: <CALiE4M0QWS-Hz2MK-M+h75_NTtN39By9A72XHWQEu_fObF6Svw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f175.google.com (mail-io0-f175.google.com
 [209.85.223.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 7876D26084B
 for <alsa-devel@alsa-project.org>; Sun,  9 Aug 2015 03:48:24 +0200 (CEST)
Received: by ioii16 with SMTP id i16so142199038ioi.0
 for <alsa-devel@alsa-project.org>; Sat, 08 Aug 2015 18:48:23 -0700 (PDT)
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Wall time obtained from do_gettimeofday is susceptible to sudden jumps due
to
user setting the time or due to NTP.

Monotonic time is constantly increasing time better suited
for comparing two timestamps.
---
 sound/pci/es1968.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index b0e3d92..6830c31 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -1710,7 +1710,7 @@ static void es1968_measure_clock(struct es1968 *chip)
  int i, apu;
  unsigned int pa, offset, t;
  struct esm_memory *memory;
- struct timeval start_time, stop_time;
+ struct timespec start_time, stop_time;

  if (chip->clock == 0)
  chip->clock = 48000; /* default clock value */
@@ -1759,12 +1759,12 @@ static void es1968_measure_clock(struct es1968
*chip)
  snd_es1968_bob_inc(chip, ESM_BOB_FREQ);
  __apu_set_register(chip, apu, 5, pa & 0xffff);
  snd_es1968_trigger_apu(chip, apu, ESM_APU_16BITLINEAR);
- do_gettimeofday(&start_time);
+ ktime_get_ts(&start_time);
  spin_unlock_irq(&chip->reg_lock);
  msleep(50);
  spin_lock_irq(&chip->reg_lock);
  offset = __apu_get_register(chip, apu, 5);
- do_gettimeofday(&stop_time);
+ ktime_get_ts(&stop_time);
  snd_es1968_trigger_apu(chip, apu, 0); /* stop */
  snd_es1968_bob_dec(chip);
  chip->in_measurement = 0;
@@ -1776,11 +1776,11 @@ static void es1968_measure_clock(struct es1968
*chip)
  offset += chip->measure_count * (CLOCK_MEASURE_BUFSIZE/2);

  t = stop_time.tv_sec - start_time.tv_sec;
- t *= 1000000;
- if (stop_time.tv_usec < start_time.tv_usec)
- t -= start_time.tv_usec - stop_time.tv_usec;
+ t *= USEC_PER_SEC;
+ if (stop_time.tv_nsec < start_time.tv_nsec)
+ t -= (start_time.tv_nsec - stop_time.tv_nsec)/NSEC_PER_USEC;
  else
- t += stop_time.tv_usec - start_time.tv_usec;
+ t += (stop_time.tv_nsec - start_time.tv_nsec)/NSEC_PER_USEC;
  if (t == 0) {
  snd_printk(KERN_ERR "?? calculation error..\n");
  } else {
-- 
1.7.9.5
