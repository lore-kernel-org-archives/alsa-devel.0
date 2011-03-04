From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: 1.0.24 alsa-driver compilation problem
Date: Fri, 04 Mar 2011 15:42:44 +0100
Message-ID: <4D70FA64.9070203@ladisch.de>
References: <4D70B9DA.8070607@elproma.com.pl> <4D70E701.3050500@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 3DF8E24391
	for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2011 15:41:18 +0100 (CET)
In-Reply-To: <4D70E701.3050500@elproma.com.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grzegorz Daniluk <g.daniluk@elproma.com.pl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Grzegorz Daniluk wrote:
> > snd: Unknown symbol unregister_sound_special (err 0)
> > snd: Unknown symbol register_sound_special_device (err 0)
> 
> ok, when I add the --with-oss=no option to ./configure those warnings 
> disappear and I can load the module without any problems. But still.. 
> how can I compile alsa to have also oss emulation

You need to enable OSS emulation in the kernel; try CONFIG_SOUND_PRIME.


Regards,
Clemens
