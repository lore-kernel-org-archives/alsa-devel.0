From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Alsa MMAP emulation
Date: Wed, 05 Mar 2008 16:51:15 +0100
Message-ID: <47CEC173.2060005@ladisch.de>
References: <47CE7A47.80009@xwaves.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 7F3F024418
	for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2008 16:49:45 +0100 (CET)
In-Reply-To: <47CE7A47.80009@xwaves.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mathieu Monney <zittix_all@xwaves.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mathieu Monney wrote:
> I'm trying to get working Alsa with the PortAudio library on an embedded
> device (Nokia N810). The problem is that the sound driver is not an
> hardware driver for Alsa but a plugin which deals with the internal DSP
> of the device. This plugin doesn't support mmap'ing at all. So I was
> wondering if it is possible to configure Alsa a way such PortAudio can
> use mmap'ing on my DSP plugin ? I saw there is a mmap_emulation flag but
> the problem is that it seems to be only available on HW driver and not
> on alsa plugins.

In alsa-lib 1.0.15, this function was moved into the mmap_emul plugin.


HTH
Clemens
