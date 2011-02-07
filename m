From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 0/2] hdspmixer: RME AES/AES32 support
Date: Mon,  7 Feb 2011 18:55:24 +0100
Message-ID: <1297101326-10509-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

Here's another round of patches for hdspmixer. They add support for the
RME AES and RME AES32 cards (same ID, only difference is PCIe vs. PCI).

Also includes some minor style fixes and formerly missing commas.


Cheers

Adrian Knoth (2):
  hdspmixer: Add RME HDSPe AES and AES32 support.
  hdspmixer: Style and purity fixes for name arrays.

 hdspmixer/src/HDSPMixerCard.cxx     |   22 ++++++
 hdspmixer/src/HDSPMixerOutput.cxx   |    7 ++
 hdspmixer/src/HDSPMixerSelector.cxx |  124 +++++++++++++++++++---------------
 hdspmixer/src/HDSPMixerWindow.cxx   |   10 +++
 hdspmixer/src/defines.h             |    1 +
 hdspmixer/src/hdspmixer.cxx         |    4 +
 6 files changed, 113 insertions(+), 55 deletions(-)

-- 
1.7.2.3
