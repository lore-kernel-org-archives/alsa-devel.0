From: "Vladimir I. Umnov" <uvi@ezmail.ru>
Subject: Re: nforce2 (snd_intel8x0) channels scrolling
Date: Sun, 9 Nov 2003 20:37:15 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031109203715.14e7a058.uvi@ezmail.ru>
References: <20031109172527.3b9e0a07.uvi@ezmail.ru>
	<3FAE5C65.1050309@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FAE5C65.1050309@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 09 Nov 2003 15:25:25 +0000
James Courtier-Dutton <James@superbug.demon.co.uk> wrote:

> Vladimir I. Umnov wrote:
> > Hw: a7n8x deluxe 2.0 (nforce2-c1 + MCP-T)
> > Sw: 2.6.0-test8, alsa-lib from cvs
> > lspci:
> > 00:05.0 Multimedia audio controller: nVidia Corporation: Unknown
> > device 006b (rev a2)        Subsystem: Asustek Computer, Inc.:
> > Unknown device 0c11        Flags: bus master, 66Mhz, fast devsel,
> > latency 0, IRQ 5
> >         Memory at d7000000 (32-bit, non-prefetchable) [size=512K]
> >         Capabilities: [44] Power Management version 2
> > 
> > 00:06.0 Multimedia audio controller: nVidia Corporation: Unknown
> > device 006a (rev a1)        Subsystem: Asustek Computer, Inc.:
> > Unknown device 8095        Flags: bus master, 66Mhz, fast devsel,
> > latency 0, IRQ 11
> >         I/O ports at e400 [size=256]
> >         I/O ports at d000 [size=128]
> >         Memory at d7087000 (32-bit, non-prefetchable) [size=4K]
> >         Capabilities: [44] Power Management version 2
> > 
> > Mplayer and xine used for testing in 6channels mode.
> > Channels mapping stays wrong after:
> > 1) snd_pcm_drop() called (seeking and quit);
> > 2) after long time of playing in 6channels mode, even without x-run.
> > 
> > p.s. My sblive works very well now, but my friends doesn't have
> > sblive and they want working 6channels audio under linux on nforce2.
> > 
> > p.p.s. I may help with testing or finding a bug, but I need help. I
> > new to alsa-driver and can't understand how it works, and can't find
> > how snd_pcm_drop() implemented in i810 module.
> > 
> > 
> Here is a simple speaker test program.
> I nicely tests different speaker layout modes.
> 
> Read the readme.txt file that is with it on how to use it.
> If you still get the problem with this simple program, it is certainly
> a bug in alsa.
After channels scrolled (after a few seek in mplayer, then quit),
./speaker_test-Dsurround51-c 6 works wrong (Center->Front Left,
LFE->Front Right, ...).
But after I use "front" device and then repeat test with 6 channels
setup, channel mapping is ok.
If i press ctrl+c with 6channels test and then repeat it
(snd_pcm_drop()) scrool is apear, and after i run 3 times, channels
mapping is ok.

With sblive all works perfectly!!! This is alsa-driver bug.


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
