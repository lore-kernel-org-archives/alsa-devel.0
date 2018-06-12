From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH 0/2] ALSA: usb-audio: Insertion Control for
	BADD Adaptors.
Date: Tue, 12 Jun 2018 15:31:59 +0100
Message-ID: <20180612143201.29988-1-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id ECDAF266F88
 for <alsa-devel@alsa-project.org>; Tue, 12 Jun 2018 16:32:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ruslan.bilovol@gmail.com
List-Id: alsa-devel@alsa-project.org

This patchset adds support for the Insertion Control for BADD devices (subset of UAC3).

This control is only pressent in the HEADSET ADAPTER BADD profile. The USB interrupt pipe
shall be present for this profile so the status pipe creation should also happen for BADD
devices.

Also, the bi-directional type codes have been defined so they can be used as inferred values
for the Input and Output terminals for this adapter profile.

-- 
Based on tag: next-20180612

Jorge Sanjuan (2):
  ALSA: usb-audio: Add bi-directional terminal types.
  ALSA: usb-audio: UAC3. Add insertion control for BADD.

 include/uapi/linux/usb/audio.h |  8 ++++++++
 sound/usb/mixer.c              | 45 ++++++++++++++++++++++++++++++------------
 2 files changed, 40 insertions(+), 13 deletions(-)

-- 
2.11.0
