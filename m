From: Martin Langer <martin-langer@gmx.de>
Subject: Re: bugs in usb midi alsa code?
Date: Thu, 7 Nov 2002 18:56:55 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021107175655.GB560@tuba.home>
References: <20021107160203.GB535@tuba.home> <Pine.HPX.4.33n.0211071735001.29035-100000@studcom.urz.uni-halle.de>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id SAA23242
	for <alsa-devel@alsa-project.org>; Thu, 7 Nov 2002 18:57:43 +0100
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0211071735001.29035-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 07, 2002 at 05:35:48PM +0100, Clemens Ladisch wrote:
> Martin Langer wrote:
> > On Thu, Nov 07, 2002 at 01:50:29PM +0100, Clemens Ladisch wrote:
> > > Did anybody test with a non-USB device?
> >
> > my keyboard has an additional classical MIDI OUT jack. Using this instead of
> > USB is running fine with OPL3 and amSynth. No problem occured.
> 
> What device did you use to get the MIDI data into the computer?
> 

my onboard soundcard "snd-via82xx" with game/midi-port

tuba:/tmp# cat /proc/asound/cards 
0 [82C686AB       ]: VIA686A - VIA 82C686A/B
                     VIA 82C686A/B at 0xcc00, irq 7
[..]


tuba:/tmp# cat /proc/asound/card0/id 
82C686AB


tuba:/tmp# cat /proc/asound/card0/midi0 
MPU-401 (UART)

Output 0
  Tx bytes     : 0
  Input 0
  Rx bytes     : 54393
  Buffer size  : 4096
  Avail        : 0
  Overruns     : 0


martin

-- 
"2b|!2b"


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
