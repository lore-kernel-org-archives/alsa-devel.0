From: Wang Xingchao <wangxingchao2011@gmail.com>
Subject: Re: [PATCH 2/2] ALSA: hda: support for wallclock
	timestamps
Date: Thu, 14 Jun 2012 11:32:44 +0800
Message-ID: <CA+v+29goT9xmx-h4Fuiyg6wuZFCvBvuFx=1P_=e8CfqoQFahMA@mail.gmail.com>
References: <1339619192-2733-1-git-send-email-pierre-louis.bossart@linux.intel.com>
	<1339619192-2733-3-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3DD51243B3
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Jun 2012 05:33:06 +0200 (CEST)
Received: by qcse14 with SMTP id e14so803860qcs.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Jun 2012 20:33:05 -0700 (PDT)
In-Reply-To: <1339619192-2733-3-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Pierre,

2012/6/14 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>:
> reuse code from clocksource to handle wall clock counter,
> translate cycles to timespec. The code wasn't reused as
> is as the HDA wall clock is based on 24MHz ticks. To avoid
> compounding rounding errors, the counters track cycles
> and will convert elapsed cycles to ns, instead of delta cycles
> as done in the cyclecounter code.
> Since wrapparound occurs, the timestamps are reinitialized with
> monotonic time on a trigger.
>
> TODO:
> - only re-init timecounter if there was no device active.
> - Keep the same timestamp for all devices on same chip.
> - make sure no overflow occurs in the 125/3 scaling implementation
>

I'm afraid you donot think much about the Wall Clock Counter register,
the counter will roll over to 0 within 179s under 24Mhz. Another case
maybe BCLK stop and controller reset.

thanks
--xingchao

> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
> =A0sound/pci/hda/hda_intel.c | =A0106 +++++++++++++++++++++++++++++++++++=
+++++++++-
> =A01 files changed, 105 insertions(+), 1 deletions(-)
>
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 2b6392b..f9b9bc1 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -46,6 +46,10 @@
> =A0#include <linux/mutex.h>
> =A0#include <linux/reboot.h>
> =A0#include <linux/io.h>
> +
> +#include <linux/clocksource.h>
> +#include <linux/time.h>
> +
> =A0#ifdef CONFIG_X86
> =A0/* for snoop control */
> =A0#include <asm/pgtable.h>
> @@ -426,6 +430,15 @@ struct azx_pcm {
> =A0 =A0 =A0 =A0struct list_head list;
> =A0};
>
> +struct azx_timecounter {
> + =A0 =A0 =A0 cycle_t cycle_last;
> + =A0 =A0 =A0 cycle_t mask;
> + =A0 =A0 =A0 cycle_t elapsed_cycles;
> + =A0 =A0 =A0 u64 =A0 =A0 initial_time_nsec;
> + =A0 =A0 =A0 u32 =A0 =A0 mult;
> + =A0 =A0 =A0 u32 =A0 =A0 shift;
> +};
> +
> =A0struct azx {
> =A0 =A0 =A0 =A0struct snd_card *card;
> =A0 =A0 =A0 =A0struct pci_dev *pci;
> @@ -496,6 +509,9 @@ struct azx {
>
> =A0 =A0 =A0 =A0/* reboot notifier (for mysterious hangup problem at power=
-down) */
> =A0 =A0 =A0 =A0struct notifier_block reboot_notifier;
> +
> + =A0 =A0 =A0 /* Wall clock counter */
> + =A0 =A0 =A0 struct azx_timecounter tc;
> =A0};
>
> =A0/* driver types */
> @@ -1699,6 +1715,89 @@ static inline void azx_release_device(struct azx_d=
ev *azx_dev)
> =A0 =A0 =A0 =A0azx_dev->opened =3D 0;
> =A0}
>
> +static void azx_timecounter_init(struct azx *chip)
> +{
> + =A0 =A0 =A0 struct azx_timecounter *tc =3D &chip->tc;
> + =A0 =A0 =A0 struct timespec ts;
> +
> + =A0 =A0 =A0 tc->cycle_last =3D azx_readl(chip, WALLCLK);
> + =A0 =A0 =A0 tc->elapsed_cycles =3D 0;
> + =A0 =A0 =A0 tc->mask =3D CLOCKSOURCE_MASK(32);
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* conversion from 24MHz to nsec requires fractional oper=
ation,
> + =A0 =A0 =A0 =A0* approximate 125/3 ratio
> + =A0 =A0 =A0 =A0*/
> +#define NBITS_NS 16
> + =A0 =A0 =A0 tc->mult =3D (u32)(1<<NBITS_NS)*125L/3L;
> + =A0 =A0 =A0 tc->shift =3D NBITS_NS;
> +
> + =A0 =A0 =A0 /* save initial time */
> + =A0 =A0 =A0 ktime_get_ts(&ts);
> + =A0 =A0 =A0 tc->initial_time_nsec =3D timespec_to_ns(&ts);
> +}
> +
> +/**
> + * azx_timecounter_read_delta - get nanoseconds since last call of this =
function
> + * @tc: =A0 =A0 =A0 =A0 Pointer to time counter
> + *
> + * When the underlying cycle counter runs over, this will be handled
> + * correctly as long as it does not run over more than once between
> + * calls.
> + *
> + * The first call to this function for a new time counter initializes
> + * the time tracking and returns an undefined result.
> + */
> +static u64 azx_timecounter_read_delta(struct azx_timecounter *tc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cycle_t cyc=
le_now)
> +{
> + =A0 =A0 =A0 cycle_t cycle_delta;
> + =A0 =A0 =A0 u64 nsec;
> +
> + =A0 =A0 =A0 /* calculate the delta since the last timecounter_read_delt=
a(): */
> + =A0 =A0 =A0 cycle_delta =3D (cycle_now - tc->cycle_last) & tc->mask;
> +
> + =A0 =A0 =A0 tc->elapsed_cycles +=3D cycle_delta;
> +
> + =A0 =A0 =A0 /* convert to nanoseconds: */
> + =A0 =A0 =A0 nsec =3D (u64)tc->elapsed_cycles;
> + =A0 =A0 =A0 nsec =3D (nsec * tc->mult) >> tc->shift;
> +
> + =A0 =A0 =A0 /* update time stamp of azx_timecounter_read_delta() call: =
*/
> + =A0 =A0 =A0 tc->cycle_last =3D cycle_now;
> +
> + =A0 =A0 =A0 return nsec;
> +}
> +
> +u64 azx_timecounter_read(struct azx *chip)
> +{
> + =A0 =A0 =A0 u64 nsec;
> + =A0 =A0 =A0 struct azx_timecounter *tc =3D &chip->tc;
> + =A0 =A0 =A0 cycle_t cycle_now;
> +
> + =A0 =A0 =A0 /* read cycle counter: */
> + =A0 =A0 =A0 cycle_now =3D azx_readl(chip, WALLCLK);
> +
> + =A0 =A0 =A0 /* increment time by nanoseconds since last call */
> + =A0 =A0 =A0 nsec =3D azx_timecounter_read_delta(tc, cycle_now);
> + =A0 =A0 =A0 nsec +=3D tc->initial_time_nsec;
> +
> + =A0 =A0 =A0 return nsec;
> +}
> +
> +
> +static int azx_get_wallclock_tstamp(struct snd_pcm_substream *substream,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct time=
spec *ts)
> +{
> + =A0 =A0 =A0 struct azx_pcm *apcm =3D snd_pcm_substream_chip(substream);
> + =A0 =A0 =A0 struct azx *chip =3D apcm->chip;
> + =A0 =A0 =A0 u64 nsec;
> +
> + =A0 =A0 =A0 nsec =3D azx_timecounter_read(chip);
> + =A0 =A0 =A0 *ts =3D ns_to_timespec(nsec);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> =A0static struct snd_pcm_hardware azx_pcm_hw =3D {
> =A0 =A0 =A0 =A0.info =3D =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (SNDRV_PCM_INFO_=
MMAP |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PCM=
_INFO_INTERLEAVED |
> @@ -1708,6 +1807,7 @@ static struct snd_pcm_hardware azx_pcm_hw =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* SNDRV_=
PCM_INFO_RESUME |*/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PCM=
_INFO_PAUSE |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PCM=
_INFO_SYNC_START |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SNDRV_PC=
M_INFO_HAS_WALL_CLOCK |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PCM=
_INFO_NO_PERIOD_WAKEUP),
> =A0 =A0 =A0 =A0.formats =3D =A0 =A0 =A0 =A0 =A0 =A0 =A0SNDRV_PCM_FMTBIT_S=
16_LE,
> =A0 =A0 =A0 =A0.rates =3D =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SNDRV_PCM_RATE_4=
8000,
> @@ -1981,8 +2081,10 @@ static int azx_pcm_trigger(struct snd_pcm_substrea=
m *substream, int cmd)
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0spin_unlock(&chip->reg_lock);
> =A0 =A0 =A0 =A0if (start) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (nsync =3D=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (nsync =3D=3D 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 azx_timecounter_init(chip);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* wait until all FIFOs get ready */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (timeout =3D 5000; timeout; timeout--)=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0nwait =3D 0;
> @@ -1998,6 +2100,7 @@ static int azx_pcm_trigger(struct snd_pcm_substream=
 *substream, int cmd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 azx_timecounter_init(chip);
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* wait until all RUN bits are cleared */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (timeout =3D 5000; timeout; timeout--)=
 {
> @@ -2239,6 +2342,7 @@ static struct snd_pcm_ops azx_pcm_ops =3D {
> =A0 =A0 =A0 =A0.prepare =3D azx_pcm_prepare,
> =A0 =A0 =A0 =A0.trigger =3D azx_pcm_trigger,
> =A0 =A0 =A0 =A0.pointer =3D azx_pcm_pointer,
> + =A0 =A0 =A0 .wall_clock =3D =A0azx_get_wallclock_tstamp,
> =A0 =A0 =A0 =A0.mmap =3D azx_pcm_mmap,
> =A0 =A0 =A0 =A0.page =3D snd_pcm_sgbuf_ops_page,
> =A0};
> --
> 1.7.6.5
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
