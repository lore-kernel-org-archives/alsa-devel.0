From: Nicolas Schichan <nschichan@freebox.fr>
Subject: [PATCH 0/2] ASoC: cs42l52: HP gain enum and PCM Mixer
	dB scale fixes.
Date: Wed, 29 May 2013 20:01:18 +0200
Message-ID: <1369850480-1772-1-git-send-email-nschichan@freebox.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
 by alsa0.perex.cz (Postfix) with ESMTP id B804B264FE3
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2013 20:01:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Georgi Vlaev <joe@nucleusys.com>
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Nicolas Schichan <nschichan@freebox.fr>
List-Id: alsa-devel@alsa-project.org

Hi,

The two patches in the serie contains the following fixes:

- Use the correct shift value in hp_gain_enum, effectively allowing
  the higher gain values to be effective and the correct gain value to
  be reported to userland wrt what is written to the register.

- Fix the PCM Mixer dB scale so that userland can report the correct
  dB gain values. Note that in its current form, the PCM Mixer control
  will only allow the range [-0.5 dB (0x7f), +12 dB (0x18)] to be
  programmed to the hardware. I don't know if it is intentional or
  not.

Regards,

Nicolas Schichan (2):
  ASoC: cs42l52: use correct PCM mixer TLV dB scale to match datasheet.
  ASoC: cs42l52: fix hp_gain_enum shift value.

 sound/soc/codecs/cs42l52.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
1.7.10.4
