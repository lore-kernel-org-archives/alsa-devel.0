From: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Subject: [noreply@sourceforge.net: [pcmcia-cs - Multifunction Cards] RE: configuring unsupported sound-card]
Date: Wed, 4 Sep 2002 10:03:59 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020904080358.GB19686@finnendahl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi,

This is a message from Dave Hinds concerning autoconfiguring the
PCMCIA.  I looked for pci_register_driver and grep only found it in
the binaries of snd-hdsp. Has the driver been written with the
"modern" kernel API, Dave is referring to?

--
Orm

----- Forwarded message from noreply@sourceforge.net -----

From: noreply@sourceforge.net
To: noreply@sourceforge.net
Subject: [pcmcia-cs - Multifunction Cards] RE: configuring unsupported sound-card

If the driver uses the "modern" PCI kernel API, with pci_register_driver() etc,
then it should work fine for hot plug devices.

As I said, for this to work, you need to use the kernel PCMCIA subsystem, and
enable CONFIG_HOTPLUG, and get the latest linux-hotplug package.

-- Dave
______________________________________________________________________


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
