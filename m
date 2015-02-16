From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 0/3] ALSA: hdspm - Remove various code
	duplication
Date: Tue, 17 Feb 2015 00:05:03 +0100
Message-ID: <1424127906-7530-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: adi@drcomp.erfurt.thur.de, alsa-devel@alsa-project.org, Adrian Knoth <aknoth@google.com>
List-Id: alsa-devel@alsa-project.org

From: Adrian Knoth <aknoth@google.com>

Hi!

As promised last week, here's a series that removes code duplication in
hdspm.c.

Adrian Knoth (3):
  ALSA: hdspm - DRY cleanup in .open callbacks
  ALSA: hdspm - DRY cleanup in .release callback
  ALSA: hdspm - DRY cleanup of snd_pcm_ops

 sound/pci/rme9652/hdspm.c | 141 ++++++++++++----------------------------------
 1 file changed, 35 insertions(+), 106 deletions(-)

-- 
2.1.0
