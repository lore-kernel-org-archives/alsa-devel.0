From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 0/3] [RME - HDSP] Userlevel support for RPM
Date: Thu, 28 Jul 2011 23:45:45 +0200
Message-ID: <1311889548-28617-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

Here's a series of recent work on RME RPM support. Confirmed to be
working by our one and only user so far. ;)

As soon as alsa-lib supports the RPM (it's a single define), I'll drop
the temporary define in both, hdsploader and hdspmixer.

RPM users: note that the current kernel code seems to be broken and does
not correctly detect your RPM box. More magic could be added to
hdsploader to provide a temporary workaround.


Cheers

Adrian Knoth (3):
  hdspmixer: Add support for RME RPM
  hdsploader: Add support for RME RPM
  hdsploader: Temporary define for RPM

 hdsploader/hdsploader.c             |    7 +++++++
 hdspmixer/src/HDSPMixerCard.cxx     |   11 +++++++++++
 hdspmixer/src/HDSPMixerCard.h       |    5 +++++
 hdspmixer/src/HDSPMixerOutput.cxx   |   15 +++++++++++++++
 hdspmixer/src/HDSPMixerSelector.cxx |    7 +++++++
 hdspmixer/src/HDSPMixerWindow.cxx   |    4 ++++
 hdspmixer/src/channelmap.cxx        |   12 ++++++++++++
 hdspmixer/src/channelmap.h          |    5 +++++
 hdspmixer/src/hdspmixer.cxx         |    4 ++++
 9 files changed, 70 insertions(+), 0 deletions(-)

-- 
1.7.5.4
