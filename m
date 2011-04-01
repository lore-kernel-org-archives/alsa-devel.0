From: linux@audioscience.com
Subject: [snd-asihpi 0/8] Updates to snd-asihpi driver
Date: Fri, 01 Apr 2011 15:59:44 +1300
Message-ID: <1301626792-13705-1-git-send-email-linux@audioscience.com>
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

Patch 4 is main change, allowing older cards to be accessed using mmap,
incidentally simplifying the driver by removing copy&silence callbacks.

Others are small improvements and updates.

This version has been tested with aplay/arecord, and with 
portaudio applications.

 pci/asihpi/asihpi.c       |  328 +++++++++++++++++++-------------------------
 pci/asihpi/hpi.h          |   15 +-
 pci/asihpi/hpi6000.c      |   39 ++----
 pci/asihpi/hpi6205.c      |   97 +++++++-------
 pci/asihpi/hpi_internal.h |   19 +--
 pci/asihpi/hpicmn.c       |   10 +-
 pci/asihpi/hpicmn.h       |    2 +
 pci/asihpi/hpifunc.c      |   27 ----
 pci/asihpi/hpimsgx.c      |   31 ++---
 pci/asihpi/hpioctl.c      |   63 +++++-----
 pci/asihpi/hpios.h        |    2 +
