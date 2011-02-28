From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 0/4] More hdspm fixes
Date: Mon, 28 Feb 2011 15:14:46 +0100
Message-ID: <1298902490-10950-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

Here are four more patches to hdspm. Most importantly, they add the
missing PCI firmware revision for AES32. Without it, loading hdspm would
crash on machines with these cards. To prevent such a crash upon unknown
firmware revisions, I've created a second patch adding a default case to
the firmware switch-case statement.

Also worth mentioning: midi port initialization is now no longer
hardcoded, thus fixing a bootup problem on MADIface.

All patches have been runtime tested on MADIface, AES32, AES (PCIe) and
RayDAT.


Cheers

Adrian Knoth (4):
  ALSA: hdspm - AES32: Use define instead of hardcoded channel count
  ALSA: hdspm - Add updated firmware revision for AES32
  ALSA: hdspm - Abort on unknown firmware revision
  ALSA: hdspm - Fix midi port initialization

 sound/pci/rme9652/hdspm.c |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

-- 
1.7.4.1
