From: Paul Davis <pbd@op.net>
Subject: Re: snd-hdsp and PCMCIA
Date: Sun, 01 Sep 2002 12:54:18 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17lXwv-0002Op-00@usw-sf-list1.sourceforge.net>
References: <20020901083758.GA1088@finnendahl.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Sun, 01 Sep 2002 10:37:58 +0200."
             <20020901083758.GA1088@finnendahl.de>
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

>asking about autoconfiguring the snd-hdsp upon card insertion I got
>the following response from David Hinds, the maintainer of pcmcia-cs:
>
>> You probably want to be using the kernel PCMCIA subsystem, together
>> with a more current version of the pcmcia-cs package.  And a
>> current linux-hotplug package.  With that combination, the hotplug
>> scripts should be capable of loading the snd-hdsp driver, if it uses
>> the hot plug PCI API's.
>>
>> You can't use cardmgr to autoload this driver because it is not a
>> "real" CardBus driver and doesn't use the CardBus API's.
>
>Does the snd-hdsp code indeed use any of the hot plug PCI API?

no, it treats the PCMCIA no differently in any way, shape or form from
the PCI interface. my readings of the kernel archives and the kernel
source before i started work on the driver suggested to me that this
was the underlying model for the design of the kernel. there is lots
of code in the kernel designed to make such devices look like ordinary
PCI devices, and it seemed sensible to me to use it. the hotplug stuff
didn't strike me as requiring any specific driver support. seems that
i may have been wrong.

if david or someone else can point me at some docs on what would be
needed to have cardmgr be able to use the driver, i would be happy to
consider adding it.

--p


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
