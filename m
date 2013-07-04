From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 00/11] HDSPM: RME AIO/RayDAT extensions and
	cleanups
Date: Thu,  4 Jul 2013 15:16:27 +0200
Message-ID: <1372943796-18998-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

Here's a series of patches that most importantly add support for AIO's
Analog Expansion Boards (AEBs) and all the missing controls to adjust
card settings (output levels, optical/coaxial etc.).

I also refactored a couple of functions to clean up the code and fixed
the S/PDIF sync/frequency reporting.


Cheers

Adrian Knoth (11):
  ALSA: hdspm - Add missing defines for RME AIO and RayDAT
  ALSA: hdspm - Introduce hdspm_is_raydat_or_aio()
  ALSA: hdspm - Augment HDSPM_TOGGLE_SETTING for AIO/RayDAT
  ALSA: hdspm - Drop duplicate code in hdspm_set_system_clock_mode()
  ALSA: hdspm - Add S/PDIF and WCK48 controls for RME RayDAT
  ALSA: hdspm - Add S/PDIF, XLR, WCK48 and ADAT-in controls for RME AIO
    cards
  ALSA: hdspm - Refactor ENUMERATED_CTL_INFO into function
  ALSA: hdspm - Introduce generic AIO tristate control
  ALSA: hdspm - Enable AD/DA/PH gains and S/PDIF-Input select on AIO
  ALSA: hdspm - Add support for AEBs on RME AIO
  ALSA: hdspm - Fix S/PDIF Sync status and frequency on RME AIO

 sound/pci/rme9652/hdspm.c | 254 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 199 insertions(+), 55 deletions(-)

-- 
1.8.3.1
