From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 0/4] hdspmixer: rescue current mixer settings
	when switching cards
Date: Mon,  4 Apr 2011 14:34:26 +0200
Message-ID: <1301920470-4615-1-git-send-email-adi@drcomp.erfurt.thur.de>
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


This series of patches was developed for EMAtech. They discovered that
when running with multiple cards, switching between cards would lose all
current changes made to the last active card.

Obviously, this is undesired behaviour. Though rather small, it nearly
took me 6hrs to get this right, and it could still be improved, but I
like to take hdspmixer into a completely different direction:

I want to remove the card switching code completely and simply run a
single instance per card, that is, if you have more than one card,
you'll say something like hdspmixer -c 1 (or even a card name).

Likewise, the preset files should then only contain the settings for a
single card. Right now, it stores everything for three cards, and if you
have four, then you'd be left in the rain. Also, when the order of cards
changes, the mixer settings would end up on the wrong card.

Long story short: the current approach is a dead-end.


Cheers

Adrian Knoth (4):
  hdspmixer: Add a 9th pseudo preset
  hdspmixer: Save preset before switching cards
  hdspmixer: Recall 1st preset on all cards, not just on the first
  hdspmixer: Initialize headphones out in presets

 hdspmixer/src/HDSPMixerCard.cxx         |    1 +
 hdspmixer/src/HDSPMixerCard.h           |    2 +
 hdspmixer/src/HDSPMixerCardSelector.cxx |    2 +
 hdspmixer/src/HDSPMixerIOMixer.cxx      |    2 +-
 hdspmixer/src/HDSPMixerIOMixer.h        |    2 +-
 hdspmixer/src/HDSPMixerOutput.cxx       |    4 +-
 hdspmixer/src/HDSPMixerOutput.h         |    2 +-
 hdspmixer/src/HDSPMixerWindow.cxx       |   48 ++++++++++++++++++++++++++++--
 hdspmixer/src/HDSPMixerWindow.h         |    4 ++-
 hdspmixer/src/defines.h                 |    6 ++++
 10 files changed, 63 insertions(+), 10 deletions(-)

-- 
1.7.4.1
