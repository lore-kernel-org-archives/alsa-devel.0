From: Eliot Blennerhassett <eblennerhassett@audioscience.com>
Subject: Re: [PATCH] Sync with AudioScience current CVS at
	version 4.03.04
Date: Tue, 02 Feb 2010 21:16:11 +1300
Message-ID: <4B67DF4B.2050308@audioscience.com>
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
To: alsa-devel@alsa-project.org, patch@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Greetings,

The just submitted patch requires matching firmware
http://audioscience.com/internet/download/firmware/dspbins40304.zip

As usual, my apologies for the large patch.  Unfortunately it was not
possible to split into unrelated subpatches without manually recreating
the commit history from our CVS repository.

>  b/pci/asihpi/Makefile           |    2 
>  b/pci/asihpi/asihpi.c           |  297 +++----
>  b/pci/asihpi/hpi.h              | 1446 ++++++++++++++++++------------------
>  b/pci/asihpi/hpi6000.c          |  102 +-
>  b/pci/asihpi/hpi6205.c          |  678 +++++++++--------
>  b/pci/asihpi/hpi6205.h          |   23 
>  b/pci/asihpi/hpi_internal.h     |  537 +++++++++++--
>  b/pci/asihpi/hpicmn.c           |   68 -
>  b/pci/asihpi/hpidebug.c         |   40 -
>  b/pci/asihpi/hpidebug.h         |   44 -
>  b/pci/asihpi/hpidspcd.h         |   37 
>  b/pci/asihpi/hpifunc.c          | 1571 ++++++++++++++++++++++++++--------------
>  b/pci/asihpi/hpimsginit.c       |   92 +-
>  b/pci/asihpi/hpimsginit.h       |   33 
>  b/pci/asihpi/hpimsgx.c          |  187 ++--
>  b/pci/asihpi/hpioctl.c          |  202 +++--
>  b/pci/asihpi/hpios.c            |  147 +++
>  b/pci/asihpi/hpios.h            |  234 ++++-
>  b/pci/asihpi/hpipcida.h         |    6 
>  pci/asihpi/hpios_linux_kernel.c |  116 --
>  pci/asihpi/hpios_linux_kernel.h |  189 ----
>  21 files changed, 3596 insertions(+), 2455 deletions(-)

regards

Eliot Blennerhassett
AudioScience Inc.
