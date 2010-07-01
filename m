From: linux@audioscience.com
Subject: Update asihpi to hpi version 4.03.36
Date: Fri, 02 Jul 2010 11:23:29 +1200
Message-ID: <1278026615-16153-1-git-send-email-linux@audioscience.com>
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

 pci/asihpi/asihpi.c       |   10 +-
 pci/asihpi/hpi.h          |   68 +++++++---
 pci/asihpi/hpi6000.c      |    7 +
 pci/asihpi/hpi_internal.h |   30 +++--
 pci/asihpi/hpicmn.c       |   10 +-
 pci/asihpi/hpidebug.c     |    2 +-
 pci/asihpi/hpidebug.h     |    4 +-
 pci/asihpi/hpifunc.c      |  324 +++++++++++++++++++++++++++------------------
 pci/asihpi/hpioctl.c      |    4 +-
