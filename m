From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: No mixers on ATI RS780 Azalia
Date: Thu, 27 May 2010 13:42:25 +0200
Message-ID: <4BFE5AA1.7070103@ladisch.de>
References: <alpine.LSU.2.01.1005261303170.19406@obet.zrqbmnf.qr>
	<s5hmxvmzwwd.wl%tiwai@suse.de>
	<alpine.LSU.2.01.1005261413040.23865@obet.zrqbmnf.qr>
	<4BFD2901.20800@ladisch.de>
	<alpine.LSU.2.01.1005271230340.18087@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 0CEBE24444
	for <alsa-devel@alsa-project.org>;
	Thu, 27 May 2010 13:42:32 +0200 (CEST)
In-Reply-To: <alpine.LSU.2.01.1005271230340.18087@obet.zrqbmnf.qr>
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

Jan Engelhardt wrote:
> On Wednesday 2010-05-26 15:58, Clemens Ladisch wrote:
> > Try unmuting and raising both the Master and Beep controls.
> 
> I unmuted everything and bumped the sliders to 100% but that does not
> change a thing unfortunately; opening the right device (C1D3p) ...

Please do not assume that the "HDMI" device is the right one, since you
never got either one to work in Linux.  You did try playing through
the "SB" card, didn't you?

It is possible that an embedded device like this requires some custom
initialization.  Can you find out if the Windows driver is the standard
Microsoft driver or Samsung's?


Regards,
Clemens
