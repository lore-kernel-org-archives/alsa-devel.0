From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 0/5] Even more hdspmixer fixes
Date: Tue,  1 Mar 2011 10:42:22 +0100
Message-ID: <1298972547-8759-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

Next round of hdspmixer updates. Mostly cosmetics, but also fixing a
segfault with H9652 cards.

Thanks to Craig Bourne for immediate testing, also tested and confirmed
to be working on RayDAT, Multiface and AES32.


Adrian Knoth (5):
  hdspmixer: Fix compiler warnings.
  hdspmixer: Don't use hardcoded number of cards.
  hdspmixer: Make static destination maps extern
  hdspmixer: Lower nesting depth in label assignment
  hdspmixer: Fix labels on H9652

 hdspmixer/pixmaps/Slider1.xpm        |    2 +-
 hdspmixer/pixmaps/Slider2.xpm        |    2 +-
 hdspmixer/pixmaps/Zlmloop2.xpm       |    2 +-
 hdspmixer/pixmaps/Zlmloopm2.xpm      |    2 +-
 hdspmixer/pixmaps/b_blank.xpm        |    2 +-
 hdspmixer/pixmaps/b_card1.xpm        |    2 +-
 hdspmixer/pixmaps/b_card2.xpm        |    2 +-
 hdspmixer/pixmaps/b_card3.xpm        |    2 +-
 hdspmixer/pixmaps/b_mute.xpm         |    2 +-
 hdspmixer/pixmaps/b_pre1.xpm         |    2 +-
 hdspmixer/pixmaps/b_pre2.xpm         |    2 +-
 hdspmixer/pixmaps/b_pre3.xpm         |    2 +-
 hdspmixer/pixmaps/b_pre4.xpm         |    2 +-
 hdspmixer/pixmaps/b_pre5.xpm         |    2 +-
 hdspmixer/pixmaps/b_pre6.xpm         |    2 +-
 hdspmixer/pixmaps/b_pre7.xpm         |    2 +-
 hdspmixer/pixmaps/b_pre8.xpm         |    2 +-
 hdspmixer/pixmaps/b_save.xpm         |    2 +-
 hdspmixer/pixmaps/b_solo.xpm         |    2 +-
 hdspmixer/pixmaps/b_zlm.xpm          |    2 +-
 hdspmixer/pixmaps/buttons.xpm        |    2 +-
 hdspmixer/pixmaps/empty.xpm          |    2 +-
 hdspmixer/pixmaps/empty_2.xpm        |    2 +-
 hdspmixer/pixmaps/empty_linux.xpm    |    2 +-
 hdspmixer/pixmaps/iomixer.xpm        |    2 +-
 hdspmixer/pixmaps/iomixer_r.xpm      |    2 +-
 hdspmixer/pixmaps/level.xpm          |    2 +-
 hdspmixer/pixmaps/matrix_black.xpm   |    2 +-
 hdspmixer/pixmaps/matrix_grey.xpm    |    2 +-
 hdspmixer/pixmaps/matrix_grey_l.xpm  |    2 +-
 hdspmixer/pixmaps/matrix_grey_o.xpm  |    2 +-
 hdspmixer/pixmaps/matrix_grey_ol.xpm |    2 +-
 hdspmixer/pixmaps/matrix_mute.xpm    |    2 +-
 hdspmixer/pixmaps/matrix_white.xpm   |    2 +-
 hdspmixer/pixmaps/matrix_yellow.xpm  |    2 +-
 hdspmixer/pixmaps/monitor.xpm        |    2 +-
 hdspmixer/pixmaps/mute.xpm           |    2 +-
 hdspmixer/pixmaps/output.xpm         |    2 +-
 hdspmixer/pixmaps/output_r.xpm       |    2 +-
 hdspmixer/pixmaps/over.xpm           |    2 +-
 hdspmixer/pixmaps/peak.xpm           |    2 +-
 hdspmixer/pixmaps/solo.xpm           |    2 +-
 hdspmixer/src/HDSPMixerAbout.cxx     |    2 +-
 hdspmixer/src/HDSPMixerAbout.h       |    2 +-
 hdspmixer/src/HDSPMixerAboutText.h   |    2 +-
 hdspmixer/src/HDSPMixerGain.cxx      |    2 +-
 hdspmixer/src/HDSPMixerGain.h        |    2 +-
 hdspmixer/src/HDSPMixerIOMixer.h     |    4 +-
 hdspmixer/src/HDSPMixerOutput.cxx    |  189 ++++++++++--------
 hdspmixer/src/HDSPMixerOutput.h      |    4 +-
 hdspmixer/src/HDSPMixerSelector.cxx  |   38 ++--
 hdspmixer/src/HDSPMixerSelector.h    |    2 +-
 hdspmixer/src/HDSPMixerSetup.cxx     |    2 +-
 hdspmixer/src/HDSPMixerSetup.h       |    2 +-
 hdspmixer/src/Makefile.am            |    1 +
 hdspmixer/src/channelmap.cxx         |  368 ++++++++++++++++++++++++++++++++++
 hdspmixer/src/channelmap.h           |  348 ++++++---------------------------
 hdspmixer/src/pixmaps.h              |   76 ++++----
 58 files changed, 642 insertions(+), 486 deletions(-)
 create mode 100644 hdspmixer/src/channelmap.cxx

-- 
1.7.4.1
