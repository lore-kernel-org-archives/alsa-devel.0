From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Fixes in intel8x0.c
Date: Tue, 26 May 2009 01:19:06 +0200
Message-ID: <4A1B276A.4080107@insite.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id A6BD524402
	for <alsa-devel@alsa-project.org>;
	Tue, 26 May 2009 01:19:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

while trying to dive into complexities of intel8x0.c I found the following:

static struct snd_pci_quirk intel8x0_clock_list[] __devinitdata = {
	SND_PCI_QUIRK(0x0e11, 0x008a, "AD1885", 41000),
	SND_PCI_QUIRK(0x1028, 0x00be, "AD1885", 44100),
.....

Is it really supposed to be 41000, instead of 44100?


In static int snd_intel8x0_pcm_open(struct snd_pcm_substream *substream,
struct ichdev *ichdev)
...
	runtime->hw.rates = ichdev->pcm->rates;

The pcm field in ichdev is snd_ac97, while the rates field in snd_ac97
is defined

unsigned int rates[6];	/* see AC97_RATES_* defines */

I guess this way always rates[0] from the list is taken, unlike e.g. in
via82xx.c: runtime->hw.rates = chip->ac97->rates[AC97_RATES_SPDIF];

It seems a bug to me, though I may be wrong of course.


Thanks and regards,

Pavel
