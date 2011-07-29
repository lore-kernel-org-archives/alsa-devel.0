From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 0/2] hdsploader/hdspmixer: Fix RPM constant
Date: Fri, 29 Jul 2011 17:57:28 +0200
Message-ID: <1311955050-28144-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

As noticed by Takashi, the RPM constant needs to be 4, not 5. For
hdspmixer, this doesn't matter, for hdsploader, it's essential.


Adrian Knoth (2):
  hdsploader: Fix temporary RPM constant
  hdspmixer: Fix temporary RPM constant

 hdsploader/hdsploader.c       |    2 +-
 hdspmixer/src/HDSPMixerCard.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.7.5.4
