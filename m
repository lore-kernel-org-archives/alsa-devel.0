From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 00/15] Add support for Sound BlasterX AE-5
Date: Tue, 18 Sep 2018 14:33:28 -0400
Message-ID: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f196.google.com (mail-qt0-f196.google.com
 [209.85.216.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 1133626788E
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 20:34:26 +0200 (CEST)
Received: by mail-qt0-f196.google.com with SMTP id r37-v6so2700951qtc.0
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 11:34:26 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Alastair Bridgewater <alastair.bridgewater@gmail.com>, Takashi Iwai <tiwai@suse.com>, conmanx360@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch series adds support for the Sound BlasterX AE-5. I have
personally tested it, and had others test it as well. All outputs work,
front headphone, rear headphone, rear line-out, surround, digital. The
only issue currently is that the microphone suffers from inconsistency
like the Sound Blaster Z does, and Creative may be willing to help fix
that, but if they're not, I have a few ideas.

I also have the ZxR working currently. That will require some more
complicated changes of the driver, so I have left it out and just
focused on the AE-5.

Connor McAdams (15):
  ALSA: hda/ca0132 - Define new verbs and control params
  ALSA: hda/ca0132 - Add quirk for Sound BlasterX AE-5
  ALSA: hda/ca0132 - Add pincfg for AE-5
  ALSA: hda/ca0132 - Set AE-5 bools and select mixer
  ALSA: hda/ca0132 - Change ca0132_mmio_init for AE-5
  ALSA: hda/ca0132 - Add AE-5 pre-init and ca0113 functions
  ALSA: hda/ca0132 - Add AE-5 regular init setup
  ALSA: hda/ca0132 - Change firmware name and usage
  ALSA: hda/ca0132 - Merge post-dsp functions + cleanup
  ALSA: hda/ca0132 - Add DSP setup functions for AE-5
  ALSA: hda/ca0132 - Clean up ca0132_alt_out_select
  ALSA: hda/ca0132 - Add output set commands for AE-5
  ALSA: hda/ca0132 - Add input selection commands for AE-5
  ALSA: hda/ca0132 - Add AE-5 specific controls
  ALSA: hda/ca0132 - Add AE-5 exit function

 sound/pci/hda/patch_ca0132.c | 1283 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 1038 insertions(+), 245 deletions(-)

-- 
2.7.4
