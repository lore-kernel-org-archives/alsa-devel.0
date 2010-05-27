From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: No mixers on ATI RS780 Azalia
Date: Thu, 27 May 2010 14:34:18 +0200
Message-ID: <4BFE66CA.5070400@ladisch.de>
References: <alpine.LSU.2.01.1005261303170.19406@obet.zrqbmnf.qr>	<s5hmxvmzwwd.wl%tiwai@suse.de>	<alpine.LSU.2.01.1005261413040.23865@obet.zrqbmnf.qr>	<4BFD2901.20800@ladisch.de>	<alpine.LSU.2.01.1005271230340.18087@obet.zrqbmnf.qr>
	<4BFE5AA1.7070103@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id D88D6103A40
	for <alsa-devel@alsa-project.org>;
	Thu, 27 May 2010 14:34:21 +0200 (CEST)
In-Reply-To: <4BFE5AA1.7070103@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jan Engelhardt <jengelh@medozas.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Please do not assume that the "HDMI" device is the right one, since you
> never got either one to work in Linux.

Hmm, that computer is separate from the actual LCD, which has an HDMI
input, so it's possible that the HDMI output would be correct.

In that case, it's likely that you've run into this bug:
https://bugs.freedesktop.org/show_bug.cgi?id=28030

You might try the patch mentioned there, or radeonhd, or fglrx.


HTH
Clemens
