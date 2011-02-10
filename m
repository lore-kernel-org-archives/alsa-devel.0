From: linux@audioscience.com
Subject: [PATCH] asihpi: Update from 4.04 to 4.06
Date: Thu, 10 Feb 2011 17:25:53 +1300
Message-ID: <1297311981-30448-1-git-send-email-linux@audioscience.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch series updates asihpi driver from version 4.04 to 4.06

Major changes:
- hpi6205 adapters no longer signal interrupts on message 
transfer, freeing the interrupt for use by streams. This requires matching
DSP firmware.
- rewrote alsa driver pcm stream timer function so it works better with 
small buffer sizes e.g. JACK.
- update alsa control names to better conform to 'standard' style.

Minor changes: add low level volume mute control, allow adapters with 
duplicate hardware index jumpers to be discovered, fix playback start for 
non-mmap adapters.

Cosmetic changes: removal of many unused functions and data. removal of vestigial
hpi subsys pointer from hpi functions. conversion of many defines to enums,
various cleanups to comment text and some badly munged identifiers.


 asihpi.c       |  781 ++++++++---------
 hpi.h          | 1214 ++++++++++-----------------
 hpi6000.c      |  299 +++---
 hpi6205.c      |  603 +++++--------
 hpi6205.h      |    7 
 hpi_internal.h | 1118 ++++++++++++-------------
 hpicmn.c       |  480 ++++++----
 hpicmn.h       |   24 
 hpidebug.c     |  157 ---
 hpidebug.h     |  323 -------
 hpidspcd.c     |   37 
 hpidspcd.h     |    2 
 hpifunc.c      | 2498 ++++++++++++++++-----------------------------------------
 hpimsginit.c   |   18 
 hpimsginit.h   |   12 
 hpimsgx.c      |  203 +---
 hpioctl.c      |   85 -
 hpios.h        |   10 
 18 files changed, 2914 insertions(+), 4957 deletions(-)
