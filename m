From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 0/4] RME RayDAT/AIO - enable period size of 32
	samples
Date: Fri, 12 Aug 2011 21:57:45 +0200
Message-ID: <1313179069-8432-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

Here is a series of patches that enable period sizes of 32 samples on
RME RayDAT and AIO cards. It also adds 8192 samples per period for MADI
and AES cards, this mode was present in the original driver but got lost
during the merge.


Cheers

Adrian Knoth (4):
  ALSA: hdspm - Allow for 8192 period size on RME MADI and AES cards
  ALSA: hdspm - Set period_bytes_min to 32 * 4 for new RME cards
  ALSA: hdspm - Reorder period sizes according to their bit
    representation
  ALSA: hdspm - Enable 32 samples/period on RME RayDAT/AIO

 sound/pci/rme9652/hdspm.c |   50 ++++++++++++++++++++++++++++++++++++--------
 1 files changed, 41 insertions(+), 9 deletions(-)

-- 
1.7.5.4
