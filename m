From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 0/8] Even more hdspmixer fixes
Date: Mon,  7 Mar 2011 19:03:01 +0100
Message-ID: <1299520989-14273-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

After some feedback with a couple of users, here's another round of
fixes for hdspmixer.

Anybody interested in a clean rewrite-from-scratch with GTK or Qt? ;)

Cheers

Adrian Knoth (8):
  hdspmixer: Replace hardcoded 3 by MAX_CARDS
  hdspmixer: Fix preset activation segfault on AES(32)
  hdspmixer: Adjust playback channel count on Multiface.
  hdspmixer: Introduce output channel count for all cards.
  hdspmixer: Provide headphones out on Multiface/Digiface
  hdspmixer: Fix code indentation
  hdspmixer: [cosmetics] Break code into logic blocks
  hdspmixer: Show cardname in window title

 hdspmixer/src/HDSPMixerCard.cxx         |  391 +++++++++++++++++--------------
 hdspmixer/src/HDSPMixerCard.h           |    5 +-
 hdspmixer/src/HDSPMixerCardSelector.cxx |    1 +
 hdspmixer/src/HDSPMixerIOMixer.cxx      |    2 +-
 hdspmixer/src/HDSPMixerWindow.cxx       |   65 ++++--
 hdspmixer/src/HDSPMixerWindow.h         |    2 +
 hdspmixer/src/channelmap.cxx            |   11 +-
 hdspmixer/src/hdspmixer.cxx             |   21 +-
 8 files changed, 284 insertions(+), 214 deletions(-)

-- 
1.7.4.1
