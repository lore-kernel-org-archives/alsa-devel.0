From: linux@audioscience.com
Subject: [PATCH 0/7] snd-asihpi playback improvement + others
Date: Tue, 23 Mar 2010 21:14:20 +1300
Message-ID: <1269332067-25959-1-git-send-email-linux@audioscience.com>
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
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Important:  alsa-firmware/asihpi should also be updated with contents of
http://www.audioscience.com/internet/download/firmware/dspbins40313.zip

asihpi.c + hpi6205.c fix choppy audio playback on busmastering adapters
the rest are minor fixes or cosmetic

Eliot Blennerhassett (7):
  Remove obsolete comment
  - const correct pointer parameters.     - add a new stream state wait
    and function
  Reinit response size for every msg/response transaction. Minor fix
    const ptr
  Bump lib version due to added and removed APIs
  Use adapter properties for stream buffer constraints.     Default to
    less logging, remove VPRINTK3     Log buffer info in decimal.
  Keep HPI buffer pointers in sync with ALSA after prewrite.
  Support mic control caching.  Move an enum out of public api.

 pci/asihpi/asihpi.c       |  102 +++++----
 pci/asihpi/hpi.h          |  513 +++++++++++++++++++++++----------------------
 pci/asihpi/hpi6205.c      |   31 ++--
 pci/asihpi/hpi_internal.h |   33 ++-
 pci/asihpi/hpicmn.c       |   10 +
 pci/asihpi/hpidebug.h     |    6 +-
 pci/asihpi/hpifunc.c      |  469 ++++++++++++++++++++++-------------------
 pci/asihpi/hpimsginit.c   |    2 +-
 pci/asihpi/hpimsgx.c      |   26 ++-
 pci/asihpi/hpioctl.c      |    3 -
 10 files changed, 641 insertions(+), 554 deletions(-)
