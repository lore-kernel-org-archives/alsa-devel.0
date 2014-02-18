From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 0/2] alsa-lib surround 2.1 support
Date: Tue, 18 Feb 2014 16:41:47 +0100
Message-ID: <1392738109-9956-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id AACF926559B
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 16:41:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

I'm currently experimenting with different ways to make the system autodetect
if surround2.1 is available through a four channel setup (e g laptop surround
speaker) and fallback to 5.1 if it isn't.

It's a bit tricky, especially given that the LFE speaker could be on left channel,
right channel, and both, so meanwhile, this fallback should be better than nothing
and help establish a standard for upper parts of the stack (i e PulseAudio).

David Henningsson (2):
  conf: Add basic infrastructure for 2.1 surround sound
  conf: Add surround 2.1 support to all cards

 src/conf/alsa.conf               |  3 ++
 src/conf/cards/ATIIXP-SPDMA.conf |  1 +
 src/conf/cards/ATIIXP.conf       |  1 +
 src/conf/cards/Audigy.conf       |  1 +
 src/conf/cards/Audigy2.conf      |  1 +
 src/conf/cards/Aureon51.conf     |  1 +
 src/conf/cards/Aureon71.conf     |  1 +
 src/conf/cards/CA0106.conf       |  1 +
 src/conf/cards/CMI8738-MC6.conf  |  1 +
 src/conf/cards/CMI8738-MC8.conf  |  1 +
 src/conf/cards/CMI8788.conf      |  2 +-
 src/conf/cards/CS46xx.conf       |  1 +
 src/conf/cards/EMU10K1.conf      |  1 +
 src/conf/cards/EMU10K1X.conf     |  1 +
 src/conf/cards/FM801.conf        |  1 +
 src/conf/cards/FireWave.conf     |  1 +
 src/conf/cards/HDA-Intel.conf    |  1 +
 src/conf/cards/ICE1712.conf      |  1 +
 src/conf/cards/ICE1724.conf      |  1 +
 src/conf/cards/ICH.conf          |  1 +
 src/conf/cards/ICH4.conf         |  1 +
 src/conf/cards/Loopback.conf     |  1 +
 src/conf/cards/NFORCE.conf       |  1 +
 src/conf/cards/SB-XFi.conf       |  1 +
 src/conf/cards/SI7018.conf       |  1 +
 src/conf/cards/USB-Audio.conf    |  1 +
 src/conf/cards/VIA8233.conf      |  1 +
 src/conf/cards/VIA8233A.conf     |  1 +
 src/conf/cards/VIA8237.conf      |  1 +
 src/conf/pcm/Makefile.am         |  2 +-
 src/conf/pcm/surround21.conf     | 62 ++++++++++++++++++++++++++++++++++++++++
 31 files changed, 94 insertions(+), 2 deletions(-)
 create mode 100644 src/conf/pcm/surround21.conf

-- 
1.9.rc1
