From: Thorsten Knabe <linux@thorsten-knabe.de>
Subject: Re: Re: [2.6 patch] schedule obsolete OSS drivers for
 removal
Date: Tue, 2 Aug 2005 17:55:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0508021741260.22453@tek01.intern.thorsten-knabe.de>
References: <20050726150837.GT3160@stusta.de>
 <Pine.LNX.4.61.0507281636040.20815@tek01.intern.thorsten-knabe.de>
 <Pine.LNX.4.61.0507290849050.8400@tm8103.perex-int.cz>
 <Pine.LNX.4.61.0507291735500.31150@tek01.intern.thorsten-knabe.de>
 <20050731193922.GI3608@stusta.de> <105c793f0508010726dc12bc7@mail.gmail.com>
 <Pine.LNX.4.61.0508020110050.13611@tek01.intern.thorsten-knabe.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.thorsten-knabe.de (mail.thorsten-knabe.de [82.141.44.28])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E64E81E1
	for <alsa-devel@alsa-project.org>; Tue,  2 Aug 2005 17:55:23 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.61.0508020110050.13611@tek01.intern.thorsten-knabe.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thorsten Knabe <linux@thorsten-knabe.de>
Cc: Andrew Haninger <ahaning@gmail.com>, Adrian Bunk <bunk@stusta.de>, Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello.

Here are the bug id's for the various issues from the ALSA bugtracking 
system:

On Tue, 2 Aug 2005, Thorsten Knabe wrote:
> On vanilla Linux 2.6.12.3 and 2.6.13-rc4 modprobe hangs in D-state when 
> loading the snd-ad1816a module. No messages have been logged to the syslog 
> and the system is otherwise stable. Of course the sound card is unusable.

#1300: modprobe goes into D-state when inserting snd-ad1816a

> Using OSS emulation with one of the VoIP 
> phones, playback and recording stop a few seconds after the call is started. 
> Using the ALSA interface with kphone works, but there is a continuous 
> clicking approximately 3 times per second. Also audio latency is poor 
> compared to the OSS driver.

#1301: Kernel OSS emulation stops working after a few seconds when used 
with VoIP softphones

#1302: Clicking noise when using kphone with the ALSA AD1816A sound driver

> Also the ALSA driver does not have an equivalent for the "ad1816_clockfreq" 
> option of the OSS driver.

#1303: AD1816A sound driver has no parameter to adjust reference clock 
frequency

Regards
Thorsten

-- 
___
  |        | /                 E-Mail: linux@thorsten-knabe.de
  |horsten |/\nabe                WWW: http://linux.thorsten-knabe.de


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
