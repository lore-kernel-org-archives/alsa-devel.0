From: Paul Davis <pbd@op.net>
Subject: Re: PCMCIA and snd-hdsp
Date: Wed, 28 Aug 2002 14:59:32 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17k80i-0006RC-00@usw-sf-list1.sourceforge.net>
References: <20020828162406.GB557@finnendahl.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Wed, 28 Aug 2002 18:24:06 +0200."
             <20020828162406.GB557@finnendahl.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Now the snd-hammerfall-mem install o.k. but snd-hdsp segfaults (and I
>have to reboot in order to get rid of the module).

well, pcmci-cs may be at fault, but this is still a bug in the
driver. it shouldn't segfault. i guess i've assumed that certain
things are always true and that this is broken by pcmcia devices.

>I would like to know whether the problem is on the side of the
>cardservices (e.g. by not providing the necessary irq and io
>information for the hdsp driver) or how the whole mechanism works. I
>couldn't find the relvant information anywhere.

it sounds fairly likely that its pcmcia-cs that is the problem. it
seems to be the main focal point for the difference between people
with working pcmcia H-DSP's and those who do not.

i don't know what this code does that makes so much difference. i say
so much, because if you notice, its not the hdsp driver that
segfaults, but some part of the IDE code.

--p


-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
