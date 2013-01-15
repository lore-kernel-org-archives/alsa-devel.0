From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH v3 0/4] RME HDSP fixes
Date: Tue, 15 Jan 2013 18:52:19 +0100
Message-ID: <1358272343-19606-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

Changes compared to v2:
    - use snd_printd to print iobox detection time
    - use KERN_ERR in case no iobox was found
    - define HDSP_S300 as a dummy for (0x100 | HDSP_S200)

Adrian Knoth (4):
  ALSA: hdsp - Fix detection for RME RPM/Multiface/Digiface ioboxes
  ALSA: hdsp - Implement generic function to toggle settings
  ALSA: hdsp - Use HDSP_TOGGLE_SETTING to alter settings
  ALSA: hdsp - Remove obsolete settings functions

 sound/pci/rme9652/hdsp.c |  462 ++++++++++++----------------------------------
 1 file changed, 117 insertions(+), 345 deletions(-)

-- 
1.7.10.4
