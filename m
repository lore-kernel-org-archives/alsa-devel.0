From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 0/3] Cleaning up the hdspm driver
Date: Mon,  3 Dec 2012 14:55:48 +0100
Message-ID: <1354542951-1588-1-git-send-email-adi@drcomp.erfurt.thur.de>
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

Here's a series of patches to clean up more or less redundant code in
the hdspm driver. To ease the review process, I've made three separate
commits. Feel free to merge the patches if you think individual commits
are not necessary.


Cheers

Adrian Knoth (3):
  ALSA: hdspm - Implement generic function to toggle settings
  ALSA: hdspm - Use HDSPM_TOGGLE_SETTING to alter settings
  ALSA: hdspm - Remove obsolete settings functions

 sound/pci/rme9652/hdspm.c |  398 ++++-----------------------------------------
 1 file changed, 31 insertions(+), 367 deletions(-)

-- 
1.7.10.4
