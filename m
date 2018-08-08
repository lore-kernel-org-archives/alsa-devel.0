From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 00/11] Add Recon3D support + Driver cleanup
Date: Wed,  8 Aug 2018 13:34:11 -0400
Message-ID: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f65.google.com (mail-it0-f65.google.com
 [209.85.214.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 9316E2678C4
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2018 19:35:06 +0200 (CEST)
Received: by mail-it0-f65.google.com with SMTP id j81-v6so4568436ite.0
 for <alsa-devel@alsa-project.org>; Wed, 08 Aug 2018 10:35:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Alastair Bridgewater <alastair.bridgewater@gmail.com>, Takashi Iwai <tiwai@suse.com>, Connor McAdams <conmanx360@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch series adds support for the Recon3D PCI-E card. I have
personally tested it on a Recon3D that was sent to me, and included
that PCI ID in the quirk table.

Much of this patch series renames Recon3Di functions to just r3d
because both cards behave similarly.

Aside from that, I do have a question- If the PCI ID's are included in
the Window's driver .inf file, would I be good to add them in as
quirks? Or should I wait for someone with the card to test it, and
then add it once I know it works on that specific card?

Connor McAdams (11):
  ALSA: hda/ca0132 - Create mmio gpio function to make code clearer
  ALSA: hda/ca0132 - Clean up ca0132_init function.
  ALSA: hda/ca0132 - Add alt_functions unsolicited response
  ALSA: hda/ca0132 - Add quirk ID and enum for Recon3D
  ALSA: hda/ca0132 - Add Recon3D pincfg
  ALSA: hda/ca0132 - Add bool variable to enable/disable pci region2
    mmio
  ALSA: hda/ca0132 - Add Recon3D startup functions and setup
  ALSA: hda/ca0132 - Add DSP setup defaults for Recon3D
  ALSA: hda/ca0132 - Add Recon3D input and output select commands
  ALSA: hda/ca0132 - Change mixer controls for Recon3D
  ALSA: hda/ca0132 - Add exit commands for Recon3D

 sound/pci/hda/patch_ca0132.c | 276 ++++++++++++++++++++++++++++---------------
 1 file changed, 180 insertions(+), 96 deletions(-)

-- 
2.7.4
