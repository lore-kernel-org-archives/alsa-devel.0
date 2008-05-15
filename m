From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ioctl request code for specific alsa control
Date: Thu, 15 May 2008 09:28:23 +0200
Message-ID: <482BE617.30207@ladisch.de>
References: <4829DE70.7050103@wurmsdobler.org> <482AAE0E.1020509@ladisch.de>
	<482AB7A1.6090303@wurmsdobler.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 9856724718
	for <alsa-devel@alsa-project.org>;
	Thu, 15 May 2008 09:28:27 +0200 (CEST)
In-Reply-To: <482AB7A1.6090303@wurmsdobler.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Wurmsdobler <peter@wurmsdobler.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Peter Wurmsdobler wrote:
> What ioctl request code would I have to pass in order to reach this
> control's put/get methods?

snd_ctl_elem_write() (alsa-lib/src/control/control.c)
snd_ctl_hw_elem_write() (alsa-lib/src/control/control_hw.c)
ioctl(SNDRV_CTL_IOCTL_ELEM_WRITE)
snd_ctl_ioctl() (linux/sound/core/control.c)
snd_ctl_elem_write_user()
snd_ctl_elem_write()
kctl->put()


HTH
Clemens
