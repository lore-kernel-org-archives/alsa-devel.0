From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Regressions: MSI vs HDA-Intel
Date: Thu, 01 Apr 2010 09:26:14 +0200
Message-ID: <4BB44A96.60709@ladisch.de>
References: <64bb37e1003261025l14e2d82r64ba1e90d024bea6@mail.gmail.com>	<s5hfx3nm1lh.wl%tiwai@suse.de>	<64bb37e1003261059w3de67654m11ca17f1645f6c1@mail.gmail.com>	<s5hhbo26d68.wl%tiwai@suse.de>	<64bb37e1003261407y4d46c71cr3b39fc3058e0294a@mail.gmail.com>	<s5hd3yq6anu.wl%tiwai@suse.de>
	<64bb37e1003270234p3c7a10e2kd066d4459a60bb51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 62D8124476
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Apr 2010 09:26:19 +0200 (CEST)
In-Reply-To: <64bb37e1003270234p3c7a10e2kd066d4459a60bb51@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Torsten Kaiser <just.for.lkml@googlemail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Torsten Kaiser wrote:
> So all the messages about the failing codec and MSI belong to
> 0000:01:05.2, the HDMI output.

MSI seems to be broken on all(?) Radeon IGPs; see
<http://lkml.org/lkml/2010/3/30/290>.

Torsten, what is the output of "lspci -nn" on your first system?


Regards,
Clemens
