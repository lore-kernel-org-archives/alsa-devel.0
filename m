From: Alessio Sangalli <alesan@manoweb.com>
Subject: I2S simple driver
Date: Wed, 30 Jul 2008 16:17:50 -0700
Message-ID: <4890F69E.8010207@manoweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A50E24478
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Jul 2008 01:17:53 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi, we are writing a small driver to control a I2S interface on our
ARM-based system...

Right now we are going to implement a "easier" interface that allows to
set some parameters, and then simply write to the device that will
automatically control the DAC and then to the speakers.

Now, this is of course not ALSA compliant. How can we estimate the
effort to make this simple driver ALSA compatible so that every ALSA
application can use this device for playback? We do not have any volume
control and the range of sound "modes" is extremely limited.

bye
as
