From: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Subject: Re: PCMCIA and snd-hdsp
Date: Thu, 29 Aug 2002 21:41:32 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020829194132.GA4770@finnendahl.de>
References: <20020828162406.GB557@finnendahl.de> <200208281902.g7SJ2V257836@icemserv.folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200208281902.g7SJ2V257836@icemserv.folkwang-hochschule.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I got the RME working again. It even works with the new pcmcia-cs.  I
also posted a message on pcmcia-cs in order to get the config file
right (its in /etc/pcmcia/config and I got part of it working, but it
doesn't yet do it all the way; I'll post it if I succeed).

I had to do about 10 kernel compiles until I found the right
combination of modules or compiled-in features. I don't exactly know,
what made it work. Following are the specs of my working kernel-config
file which might be important:

- Support for hot pluggable devices are compiled into the kernel
- pcmcia is compiled into the kernel
- Cardbus Support is compiled into the kernel
- i82365 compatible bridge is compiled into the kernel
- all other options concerning PCMCIA are disabled
- Hotplug support (PCI) is disabled
- Plug and Play support is disabled

After that I recompiled the Alsa-driver and AlsaLib and it worked
right away.


Am Mittwoch, den 28. August 2002 um 14:59:32 Uhr (-0400) schrieb Paul Davis:

> i don't know what this code does that makes so much difference. i say
> so much, because if you notice, its not the hdsp driver that
> segfaults, but some part of the IDE code.

I noticed that.

I guess, the best bet is not to use modules at all if pcmcia is
concerned, but compile everything into the kernel (although it ran
with the old card-services on my machine using modules). Also it seems
that the card is not cardbus-compatible and therefore the compatible
bridge is needed.

Thanks to all of you, who helped!!

Orm


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
