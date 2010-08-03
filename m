From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH 0/2] ALSA: hda - support HDMI HBR passthrough
Date: Tue,  3 Aug 2010 13:28:56 +0300
Message-ID: <1280831338-4596-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from saarni.dnainternet.net (saarni.dnainternet.net [83.102.40.136])
	by alsa0.perex.cz (Postfix) with ESMTP id 25892243CF
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 12:29:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi all!

This patchset adds support for passing through IEC 61937 encapsulated
compressed audio at high bitrates (i.e. those over 6.144Mbps).
At least TrueHD and DTS-HD are such formats.

I've tested this using an NVIDIA hdmi codec and the following ffmpeg
patch which adds support for TrueHD in its IEC 61937 muxer:
http://lists.mplayerhq.hu/pipermail/ffmpeg-devel/2010-August/094317.html

One needs to set the AES0 & 0x02 (non-audio) bit during playback so that
the data is not transmitted as normal 8 channel PCM audio.

---
Anssi Hannula (2):
      ALSA: hda - Set Stream Type in Stream Format according to AES0
      ALSA: hda - Add support for HDMI HBR passthrough

 sound/pci/hda/hda_codec.c       |    6 ++++-
 sound/pci/hda/hda_codec.h       |    6 ++++-
 sound/pci/hda/hda_intel.c       |    3 +-
 sound/pci/hda/patch_hdmi.c      |   40 ++++++++++++++++++++++++++++++++++++++-
 sound/pci/hda/patch_intelhdmi.c |    3 +-
 sound/pci/hda/patch_nvhdmi.c    |    3 +-
 6 files changed, 53 insertions(+), 8 deletions(-)
