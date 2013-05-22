From: Nicolas Schichan <nschichan@freebox.fr>
Subject: [PATCH 0/4] CS42L52 fixes.
Date: Wed, 22 May 2013 19:19:23 +0200
Message-ID: <1369243167-28700-1-git-send-email-nschichan@freebox.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
 by alsa0.perex.cz (Postfix) with ESMTP id A1228260785
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 19:19:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Brian Austin <brian.austin@cirrus.com>, Georgi Vlaev <joe@nucleusys.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Nicolas Schichan <nschichan@freebox.fr>
List-Id: alsa-devel@alsa-project.org

Hi,

In the following emails, you will find the fixes I currently have for
the CS42L52 driver.

The fixes are:

- Set both Master Volume A & B init value to 0x88 (otherwise left
  channel and right channel master volume would not be the same after
  init).

- Use IFACE_CTL2 register for Microphone Bias enum (IFACE_CTL1 is
  clearly not controling microphone bias according to the datasheet).

- Various controls would use a bogus shift value, resulting in only the
  high order bits being updated when changing them.

- The wrong mask was used when muting/unmuting the codec, resutling in
  the wrong part of the PB_CTL1 register being cleared, especially the
  headphone analog gain part.

All those patches are against the latest linus tree.

Regards,

-- 
Nicolas Schichan
