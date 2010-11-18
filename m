From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] disable period wakeups
Date: Thu, 18 Nov 2010 09:57:18 +0100
Message-ID: <4CE4EA6E.8070500@ladisch.de>
References: <AANLkTimLAuzn+rSEGTv2oV_yPErbBHdRdij-61Ya2JcE@mail.gmail.com>
	<4CE1043A.6010607@ladisch.de>
	<alpine.LNX.2.00.1011151123380.29422@eeebox2.perex-int.cz>
	<4CE24CAC.2070909@ladisch.de>
	<alpine.LNX.2.00.1011180929490.21207@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 41C8D103900
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2010 09:55:34 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.1011180929490.21207@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: pl bossart <bossart.nospam@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Tue, 16 Nov 2010, Clemens Ladisch wrote:
> > How about this?
> 
> The patch bellow looks good. I would probably add some lightweight
> condition on top like:
> 
>  	if (jdelta < runtime->hw_ptr_buffer_jiffies / 2 + 1)
>  		goto no_delta_check;
> 
> But it's just an optimization. Please, commit.

Done.


Regards,
Clemens
