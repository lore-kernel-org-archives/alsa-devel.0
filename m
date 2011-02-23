From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 0/8] Fixes for HDSPM, especially AES(32)
Date: Wed, 23 Feb 2011 11:43:07 +0100
Message-ID: <1298457795-28114-1-git-send-email-adi@drcomp.erfurt.thur.de>
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


Florian Faber, Fredrik Lingvall and me have gone through an e-mail debug
session during the past few weeks.

Here's our result containing several fixes for RME cards.


Cheers

Adrian Knoth (8):
  ALSA: hpdsm - RME AES(32): Fix missing channel mappings
  ALSA: hdspm - Fix buffer handling on RME MADI/MADIface/AES(32)
  ALSA: hdspm - Restrict channel count on RME AES/AES32
  ALSA: hdspm - Fix DS/QS output channel mappings on RME MADI/MADIface
  ALSA: hdspm - Remove input selector on MADIface
  ALSA: hdspm - fix sync check on AES32
  ALSA: hdspm - prevent reading unitialized stack memory
  ALSA: hdspm - Fix lock/sync reporting on MADI and AES32

 sound/pci/rme9652/hdspm.c |  130 +++++++++++++++++++++++++++++++++++---------
 1 files changed, 103 insertions(+), 27 deletions(-)

-- 
1.7.2.3
