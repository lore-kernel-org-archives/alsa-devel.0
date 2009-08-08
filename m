From: Jon Smirl <jonsmirl@gmail.com>
Subject: ASoC: PCM formats for AC97
Date: Sat, 8 Aug 2009 14:44:48 -0400
Message-ID: <9e4733910908081144s27f4b7fes1e22f838a203c3cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f203.google.com (mail-yw0-f203.google.com
	[209.85.211.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 918C82434B
	for <alsa-devel@alsa-project.org>;
	Sat,  8 Aug 2009 20:44:49 +0200 (CEST)
Received: by ywh41 with SMTP id 41so3324594ywh.23
	for <alsa-devel@alsa-project.org>; Sat, 08 Aug 2009 11:44:48 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Tell me if this is right and I'll do a patch....

-----------------------------------------------------------
The current mpc5200 code has:

static const struct snd_pcm_hardware psc_dma_hardware = {
	.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_BE |
		SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S32_BE,

struct snd_soc_dai psc_ac97_dai[] = {
{
	.playback = {
		.formats = SNDRV_PCM_FMTBIT_S32_BE,

I think I have this backwards, the ac97 driver can take 8/16/24/32
it's the Bestcomm program that doesn't know about anything except 32b.
So if we wrote new Bestcomm programs that expanded bytes from memory
out into 32b DMA register writes, we could support 8/16b formats.

The correct formats would be:
static const struct snd_pcm_hardware psc_dma_hardware = {
	.formats = SNDRV_PCM_FMTBIT_S32_BE,

struct snd_soc_dai psc_ac97_dai[] = {
{
	.playback = {
		.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_BE |
			SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S32_BE,

After implementing new Bestcomm programs....

static const struct snd_pcm_hardware psc_dma_hardware = {
	.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_BE |
		SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S32_BE,

-----------------------------------------------------------
A related issue in soc-dai.h:

#define SND_SOC_STD_AC97_FMTS (SNDRV_PCM_FMTBIT_S16_LE |\
                               SNDRV_PCM_FMTBIT_S32_LE |\
                               SNDRV_PCM_FMTBIT_S32_BE)

shouldn't this be
#define SND_SOC_STD_AC97_FMTS (SNDRV_PCM_FMTBIT_S16 |\
                               SNDRV_PCM_FMTBIT_S32)

The first form says the AC97 hardware can take both endians, but it
doesn't take both endians it takes the endian matching the machine it
is attached to.
Don't the standard AC97 formats also include 8 and 24b?

-- 
Jon Smirl
jonsmirl@gmail.com
