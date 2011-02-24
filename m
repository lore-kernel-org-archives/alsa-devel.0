From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 0/6] hdspmixer fixes
Date: Thu, 24 Feb 2011 21:33:25 +0100
Message-ID: <1298579611-16573-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

Here's a collection of fixes to hdspmixer. Besides style fixes, it
re-enables support for Multiface/Digiface and other non-MADI cards.

The support was accidently lost when merging hdspmixer64 with hdspmixer.
Today, RME has provided me with two cards (Multiface and AES32), so I
had the opportunity to fix the broken bits.

Also, the old code never handled three cards correctly, but that's
fixed, too. (and tested against the three RME cards currently in my
workstation)


Cheers


Adrian Knoth (6):
  hdspmixer: Improve code coherency
  hdspmixer: Update FSF address.
  hdspmixer: Increase height of about window.
  hdspmixer: Bump version number to 1.10
  hdspmixer: Fix ALSA snd_ctl_open error when running with three cards.
  hdspmixer: Fix metering for non-MADI cards

 hdspmixer/configure.in               |    2 +-
 hdspmixer/src/HDSPMixerAboutText.cxx |   13 ++-
 hdspmixer/src/HDSPMixerCard.cxx      |  163 ++---------------------
 hdspmixer/src/HDSPMixerOutput.cxx    |    4 +-
 hdspmixer/src/HDSPMixerSelector.cxx  |    7 +-
 hdspmixer/src/HDSPMixerWindow.cxx    |   75 +++++++----
 hdspmixer/src/HDSPMixerWindow.h      |    4 +-
 hdspmixer/src/channelmap.h           |  234 +++++++++++++++++++++++++++++++---
 hdspmixer/src/defines.h              |    4 +-
 hdspmixer/src/hdspmixer.cxx          |    3 +
 hdspmixer/src/mappings.h             |   93 --------------
 11 files changed, 308 insertions(+), 294 deletions(-)
 delete mode 100644 hdspmixer/src/mappings.h

-- 
1.7.2.3
