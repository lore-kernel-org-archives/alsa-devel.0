From: Russ Garrett <russ@garrett.co.uk>
Subject: Re: "does not support 28bit PCI busmaster DMA" on
	AMD64
Date: Sat, 08 May 2004 18:06:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1084035972.7630.1.camel@localhost>
References: <1083263559.6227.39.camel@localhost>
	 <s5hr7u133yo.wl@alsa2.suse.de>
Reply-To: russ@garrett.co.uk
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr7u133yo.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2004-05-03 at 16:50, Takashi Iwai wrote:
> At Thu, 29 Apr 2004 19:32:39 +0100,
> Russ Garrett wrote:
> > Whenever I try to modprobe snd_ice1712, I get the following error in
> > dmesg:
> > 
> > architecture does not support 28bit PCI busmaster DMA
> > ICE1712: probe of 0000:01:0a.0 failed with error -6
> 
> you can try "soft" boot option.
> or, simply ignore the dma address check as the patch attached below :)

Thanks, the patch works fine for me. I don't fully understand what the
problem is - is this likely to be fixed in a future version?

--
Russ Garrett
russ@garrett.co.uk



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
