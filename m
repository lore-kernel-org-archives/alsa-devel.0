From: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Subject: snd-hdsp and PCMCIA
Date: Sun, 1 Sep 2002 10:37:58 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020901083758.GA1088@finnendahl.de>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

asking about autoconfiguring the snd-hdsp upon card insertion I got
the following response from David Hinds, the maintainer of pcmcia-cs:

> You probably want to be using the kernel PCMCIA subsystem, together
> with a more current version of the pcmcia-cs package.  And a
> current linux-hotplug package.  With that combination, the hotplug
> scripts should be capable of loading the snd-hdsp driver, if it uses
> the hot plug PCI API's.
>
> You can't use cardmgr to autoload this driver because it is not a
> "real" CardBus driver and doesn't use the CardBus API's.

Does the snd-hdsp code indeed use any of the hot plug PCI API?

--
Orm


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
