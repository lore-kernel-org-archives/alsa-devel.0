From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 0/3] [RME - HDSPM/MADI] Speed mode selector
Date: Fri, 29 Jul 2011 03:11:01 +0200
Message-ID: <1311901864-29021-1-git-send-email-adi@drcomp.erfurt.thur.de>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <y>
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

Here's another small series of patches for the RME MADI cards. Most
prominently, we now provide a control element to the user to explicitly
select a frequency multiplier for the MADI link.

This way, one can run applications at 64kHz and above (up to 192kHz)
even when the card is not the clock master (read: is in slave mode).



Cheers

Adrian Knoth (3):
  ALSA: hdspm - Provide MADI speed mode selector on RME MADI and
    MADIface
  ALSA: hdspm - Fix reported external sample rate on RME MADI and
    MADIface
  ALSA: hdspm - Add firmware revision 0xcc for RME MADI

 sound/pci/rme9652/hdspm.c |  109 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 107 insertions(+), 2 deletions(-)

-- 
1.7.5.4
