From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: No HDMI audio output,
 nVidia audio not listed in lspci
Date: Thu, 26 May 2011 14:23:10 +0200
Message-ID: <4DDE462E.4070709@ladisch.de>
References: <BANLkTimybCjUxvTEJZJ_qZZ8y+s7+cHcUg@mail.gmail.com>	<4DDE2C03.5030607@ladisch.de>
	<BANLkTikxCK=XiTgoDOW15kgR+LvQh7La2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 2A797103823
	for <Alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 14:20:59 +0200 (CEST)
In-Reply-To: <BANLkTikxCK=XiTgoDOW15kgR+LvQh7La2A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joost Verdoorn <jpverdoorn@gmail.com>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Joost Verdoorn wrote:
> > Did you try device "hw:0,1"?
> 
> How do I do that?

aplay -D plughw:0,1 something.wav


Regards,
Clemens
