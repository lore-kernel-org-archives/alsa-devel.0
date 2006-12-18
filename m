From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: BROKEN: Support for non-standard rates in USB
	audio driver
Date: Mon, 18 Dec 2006 12:18:20 +0100
Message-ID: <20061218111820.GD15369@kiste.smurf.noris.de>
References: <em2phs$kff$1@sea.gmane.org>
	<1166435481.26964.280955101@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1166435481.26964.280955101@webmail.messagingengine.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Clemens Ladisch:
> >     [ALSA] Support for non-standard rates in USB audio driver
> > 
> > ... because it caused this crash in snd_interval_list:
> > 
> >  EIP:    0060:[<f0a30916>]    Not tainted VLI
> >  EFLAGS: 00010202   (2.6.18-1.33 #10)
> >   [<f0a326a4>] snd_pcm_hw_rule_list+0x22/0x29 [snd_pcm]
> 
> What USB device are you using?
> 
Something cute, round, and apparently unlabeled,
except for the stylized "G" on it.  ;-)

$ pwd
/sys/devices/pci0000:00/0000:00:13.2/usb6/6-2/6-2.4
$ grep . *
bcdDevice:0100
bConfigurationValue:1
bDeviceClass:00
bDeviceProtocol:00
bDeviceSubClass:00
bmAttributes:80
bMaxPacketSize0:8
bMaxPower:500mA
bNumConfigurations:1
bNumInterfaces: 3
devnum:17
idProduct:0420
idVendor:077d
manufacturer:Griffin Technology
maxchild:0
product:iMic USB audio adapter
serial:042067
speed:12
version: 1.00
$ 

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Reality is the leading cause of stress among those in touch with it.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
