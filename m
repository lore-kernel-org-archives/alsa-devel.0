From: Danny Milosavljevic <dannym@scratchpost.org>
Subject: [PATCH v8 0/2] ASoc: sun4i-codec: Add FM, Line and Mic inputs
Date: Mon, 21 Dec 2015 12:30:47 +0100
Message-ID: <20151221123047.215306ce@dayas>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this is the eighth version of the patch set that adds inputs to sun4i-codec.

Changes compared to v7 are:
 - fix the routes for line and mic capturing.

The patches are on top of the branch "sunxi-next" in 
<git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git>.

Regards,
   Danny
---
Danny Milosavljevic (2):
  sun4i-codec: Add FM, Line and Mic inputs
  sun4i-codec: make it possible to use different codec_widgets for A10 and A20.

 b/sound/soc/sunxi/sun4i-codec.c |  230 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 215 insertions(+), 15 deletions(-)
