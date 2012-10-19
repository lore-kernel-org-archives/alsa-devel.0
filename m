From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 0/9] Fixes for RME MADI cards
Date: Fri, 19 Oct 2012 17:42:21 +0200
Message-ID: <1350661350-5000-1-git-send-email-adi@drcomp.erfurt.thur.de>
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org, andre.schramm@iosono-sound.com
List-Id: alsa-devel@alsa-project.org

Hi!

I've spent another afternoon at IOSONO to fix a series of bugs in the
hdspm driver.

Andre Schramm and me have tested almost all patches on a box with two
PCIe MADI cards and one PCI MADI card. The DDS/Varispeed patch has only
been tested on my RayDAT, the sync_in detection for AES32 has not been
tested at all, though the documentation is pretty clear that the
previous bit position was wrong. If there are AES(32) owners with two or
more cards out there, please test and report back.

The typo and the coding style patches have not been tested, since
they're trivial.


Cheers

Adrian Knoth (9):
  ALSA: hdspm - Allow DDS/Varispeed to be set from userspace
  ALSA: hdspm - Report external rate in slave mode on PCI MADI
  ALSA: hdspm - Fix sync check reporting on all RME HDSPM cards
  ALSA: hdspm - Fix reported autosync_sample_rate
  ALSA: hdspm - Also report autosync_sample_rate on MADI and MADIface
  ALSA: hdspm - Fix sync_in reporting on RME MADI cards
  ALSA: hdspm - Fix sync_in detection on AES/AES32
  ALSA: hdspm - Fix typo in kcontrol element on RME MADI cards
  ALSA: hdspm - Fix coding style in CTL_ELEM macros

 sound/pci/rme9652/hdspm.c |  232 ++++++++++++++++++++++++++-------------------
 1 file changed, 137 insertions(+), 95 deletions(-)

-- 
1.7.10.4
