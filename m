From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH v2 0/4] RME HDSP fixes
Date: Tue, 15 Jan 2013 15:18:09 +0100
Message-ID: <1358259493-17974-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

Hi,

here's v2 of my previous series of patches for the RME HDSP.

Changes to the previous version:
   - correct time value in verbose output ("iobox found after %d ms")
   - define and use constants for iobox detection (no more 0x10a0)
   - hdsp_toggle_setting: only change register if newval != oldval

Adrian Knoth (4):
  ALSA: hdsp - Fix detection for RME RPM/Multiface/Digiface ioboxes
  ALSA: hdsp - Implement generic function to toggle settings
  ALSA: hdsp - Use HDSP_TOGGLE_SETTING to alter settings
  ALSA: hdsp - Remove obsolete settings functions

 sound/pci/rme9652/hdsp.c |  461 ++++++++++++----------------------------------
 1 file changed, 116 insertions(+), 345 deletions(-)

-- 
1.7.10.4
