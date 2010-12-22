From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 2/3] ECI: introducing ECI bus driver
Date: Wed, 22 Dec 2010 09:17:51 -0800
Message-ID: <20101222091751.10009e90.randy.dunlap@oracle.com>
References: <1293020435-5680-1-git-send-email-tapio.vihuri@nokia.com>
	<1293020435-5680-2-git-send-email-tapio.vihuri@nokia.com>
	<1293020435-5680-3-git-send-email-tapio.vihuri@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet10.oracle.com (rcsinet10.oracle.com [148.87.113.121])
	by alsa0.perex.cz (Postfix) with ESMTP id 6889B243FC
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 18:18:06 +0100 (CET)
In-Reply-To: <1293020435-5680-3-git-send-email-tapio.vihuri@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tapio.vihuri@nokia.com
Cc: ilkka.koskinen@nokia.com, alsa-devel@alsa-project.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, samu.p.onkalo@nokia.com
List-Id: alsa-devel@alsa-project.org

On Wed, 22 Dec 2010 14:20:34 +0200 tapio.vihuri@nokia.com wrote:

> From: Tapio Vihuri <tapio.vihuri@nokia.com>
> 
> ECI bus controller is kind of bridge between host CPU I2C and ECI accessory
> ECI communication.
> 
> Signed-off-by: Tapio Vihuri <tapio.vihuri@nokia.com>
> ---
>  drivers/Kconfig           |    2 +
>  drivers/Makefile          |    1 +
>  drivers/ecibus/Kconfig    |   46 ++++
>  drivers/ecibus/Makefile   |   10 +
>  drivers/ecibus/ecibus.c   |  583 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/input/eci.h |    8 +
>  6 files changed, 650 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/ecibus/Kconfig
>  create mode 100644 drivers/ecibus/Makefile
>  create mode 100644 drivers/ecibus/ecibus.c


ERROR: "intel_scu_ipc_iowrite8" [drivers/ecibus/ecibus.ko] undefined!

You must have had some kernel config enabled that I don't have enabled
when you built this.  Please fix Kconfig files so that this won't happen.

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
desserts:  http://www.xenotime.net/linux/recipes/
