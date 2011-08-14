From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 0/5] RME RayDAT/AIO - enable period size of 32
	samples (v2)
Date: Mon, 15 Aug 2011 00:22:49 +0200
Message-ID: <1313360574-9891-1-git-send-email-adi@drcomp.erfurt.thur.de>
References: <20110814215943.GK19500@ltw.loris.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20110814215943.GK19500@ltw.loris.tv>
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

Changes from the previous version:
    - use hdspm_get_latency() to make the code more DRY

Adrian Knoth (5):
  ALSA: hdspm - Allow for 8192 period size on RME MADI and AES cards
  ALSA: hdspm - Set period_bytes_min to 32 * 4 for new RME cards
  ALSA: hdspm - Reorder period sizes according to their bit
    representation
  ALSA: hdspm - Introduce hdspm_get_latency() to harmonize latency
    calculation
  ALSA: hdspm - Enable 32 samples/period on RME RayDAT/AIO

 sound/pci/rme9652/hdspm.c |   61 ++++++++++++++++++++++++++++++++++----------
 1 files changed, 47 insertions(+), 14 deletions(-)

-- 
1.7.5.4
