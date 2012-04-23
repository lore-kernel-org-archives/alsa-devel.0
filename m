From: Guillaume Clement <gclement@baobob.org>
Subject: Re: [snd-usb-audio] frequent "delay: estimated xxx,
	actual yyy" messages
Date: Mon, 23 Apr 2012 21:40:37 +0200
Message-ID: <1383683.z6YHnxXImd@siegfried>
References: <3172169.OcqrdKakkS@siegfried> <4F9594AF.4090902@linux.intel.com>
Reply-To: Guillaume Clement <gclement@baobob.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
	[217.70.183.196])
	by alsa0.perex.cz (Postfix) with ESMTP id 927C0243D0
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2012 21:40:57 +0200 (CEST)
Received: from siegfried.localnet (unknown
	[IPv6:2a01:e35:8b3b:6a90:224:1dff:fe73:2eb4])
	(Authenticated sender: tortuxm@baobob.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A87081720CC
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2012 21:40:56 +0200 (CEST)
In-Reply-To: <4F9594AF.4090902@linux.intel.com>
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

On 4/23/2012 12:43:11 Pierre-Louis Bossart wrote :
> I'm the one who introduced this warning when I added support for a
> better delay estimate based on the frame counter instead of bytes
> submitted (back in September 2011). When writing new data the estimate
> using the frame counter and the byte count should be identical, but this
> message shows something goes wrong.
> Somehow I don't understand how a more precise delay would cause such
> errors. The delay is only important for pulseaudio, it shouldn't affect
> plain vanilla alsa. 

Could the delay not be the cause, but a side effect ? Unfortunately I don't 
know anything about the internals here.


What I do know is that there is a lapdesk of another series by the same 
vendor, that has exactly the same behaviour. I do know those two lapdesks work 
fine under other OSes. 

The problem can also be reproduced under various Linux distributions.



Do you have any idea why keeping my CPU busy removes the problem ? That could 
be a hint as to where the real problem lies. 

> You could try and reverse the patch to see if this
> improves anything? If not, you have another problem in your setup...

By reversing the patch, I made the problem worse. 

Is there a way to get more debugging information ? I already tried to get some 
output with xrun_debug as pointed in the wiki, but things don't look weird to 
me (I only get logs about hwptr_update and period_update)
