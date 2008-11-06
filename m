From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Any issues with GETOSPACE OSS ioctl?
Date: Thu, 06 Nov 2008 13:31:44 +0100
Message-ID: <4912E3B0.4030405@ladisch.de>
References: <4911BE9C.8010607@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id BB1132453E
	for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2008 13:31:46 +0100 (CET)
In-Reply-To: <4911BE9C.8010607@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> I have a customer who reports that when his OSS application makes several
> write() followed by SNDCTL_DSP_GETOSPACE, the returned value is not decreasing,
> which implies that the write() commands are not going through.

When write() doesn't return an error, it succeeded.

The GETOSPACE return value does not decrease as long as the written data
has not yet filled an entire fragment.  (This behaviour can be changed
with the partial-frag option; see
linux/Documentation/sound/alsa/OSS-Emulation.txt).


HTH
Clemens
