From: Paul Davis <pbd@op.net>
Subject: Re: [noreply@sourceforge.net: [pcmcia-cs - Multifunction Cards] RE: configuring unsupported sound-card]
Date: Wed, 04 Sep 2002 12:14:24 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17mcll-0002k1-00@usw-sf-list1.sourceforge.net>
References: <20020904080358.GB19686@finnendahl.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Wed, 04 Sep 2002 10:03:59 +0200."
             <20020904080358.GB19686@finnendahl.de>
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

>This is a message from Dave Hinds concerning autoconfiguring the
>PCMCIA.  I looked for pci_register_driver and grep only found it in
>the binaries of snd-hdsp. Has the driver been written with the
>"modern" kernel API, Dave is referring to?

yes, all of ALSA does this. we use pci_module_init() and
pci_unregister_driver(), amongst others. this is common to all ALSA
PCI-based drivers. pci_module_init() calls pci_register_driver() (see 
linux/include/linux/pci.h)

--p


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
