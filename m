From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Linux USB audio driver - sample code / link /
	documentation
Date: Fri, 26 Nov 2010 10:55:30 +0100
Message-ID: <4CEF8412.8040002@ladisch.de>
References: <AANLkTi=R_2dPhOGCB+5Dv_KUG3PrESg+Z+x1A_bhiTjr@mail.gmail.com>	<4CEF66FA.3090405@ladisch.de>
	<AANLkTind0TDg=gcE0Pfu2BDaadk64FKgvM-3SNVLcobd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 84363103CEC
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 10:53:20 +0100 (CET)
In-Reply-To: <AANLkTind0TDg=gcE0Pfu2BDaadk64FKgvM-3SNVLcobd@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ramya Desai <ramya.desai@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ramya Desai wrote:
> On Fri, Nov 26, 2010 at 1:21 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> > The simplest sample driver is this one:
> > http://www.alsa-project.org/~clemens/ua1a.patch
> 
> the source is also available at sound/usb/misc/ua101.c.

No, that is for a different device.  The UA-101 requires
synchronization between capture and playback stream; because
of this, the UA-1A's driver is somewhat simpler.

And there is no ALSA USB audio documentation.


Regards,
Clemens
