From: Alastair Bridgewater <alastair.bridgewater@gmail.com>
Subject: [PATCH 0/6] ALSA: hda/ca0132: Various cleanups and
	fixes
Date: Fri, 15 Jun 2018 21:56:14 -0400
Message-ID: <20180616015620.26663-1-alastair.bridgewater@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Alastair Bridgewater <alastair.bridgewater@gmail.com>
List-Id: alsa-devel@alsa-project.org

The ca0132 codec support is fairly crufty, and the new R3Di and SBZ
support hasn't exactly improved that situation.  This patch series
tries to clean up a small amount of longstanding cruft, reverse some
behavioral changes to other systems made by the recent R3Di/SBZ
patches, and make the DMic work properly on the Alienware M17x R4.

For two of these patches (the QUIRK_ALIENWARE patch and the DMic
patch), it may be that the correct behavior is the exact OPPOSITE of
what the patch does as far as quirk testing goes (that is, it should
apply globally, rather than limited to some specific quirk or set of
quirks), but I have no way to make such a determination at this time,
so erring on the side of the status quo ante seems appropriate.

Alastair Bridgewater (6):
  ALSA: hda/ca0132: Delete pointless assignments to struct auto_pin_cfg
    fields
  ALSA: hda/ca0132: Delete redundant UNSOL event requests
  ALSA: hda/ca0132: Restore behavior of QUIRK_ALIENWARE
  ALSA: hda/ca0132: Don't test for QUIRK_NONE
  ALSA: hda/ca0132: Restore PCM Analog Mic-In2
  ALSA: hda/ca0132: Fix DMic data rate for Alienware M17x R4

 sound/pci/hda/patch_ca0132.c | 62 ++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 40 deletions(-)

-- 
2.16.1
