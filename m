From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: nforce2 (snd_intel8x0) channels scrolling
Date: Sun, 09 Nov 2003 15:25:25 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FAE5C65.1050309@superbug.demon.co.uk>
References: <20031109172527.3b9e0a07.uvi@ezmail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030108030208010008020406"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031109172527.3b9e0a07.uvi@ezmail.ru>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Vladimir I. Umnov" <uvi@ezmail.ru>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030108030208010008020406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Vladimir I. Umnov wrote:
> Hw: a7n8x deluxe 2.0 (nforce2-c1 + MCP-T)
> Sw: 2.6.0-test8, alsa-lib from cvs
> lspci:
> 00:05.0 Multimedia audio controller: nVidia Corporation: Unknown device
> 006b (rev a2)        Subsystem: Asustek Computer, Inc.: Unknown device
> 0c11        Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 5
>         Memory at d7000000 (32-bit, non-prefetchable) [size=512K]
>         Capabilities: [44] Power Management version 2
> 
> 00:06.0 Multimedia audio controller: nVidia Corporation: Unknown device
> 006a (rev a1)        Subsystem: Asustek Computer, Inc.: Unknown device
> 8095        Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 11
>         I/O ports at e400 [size=256]
>         I/O ports at d000 [size=128]
>         Memory at d7087000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: [44] Power Management version 2
> 
> Mplayer and xine used for testing in 6channels mode.
> Channels mapping stays wrong after:
> 1) snd_pcm_drop() called (seeking and quit);
> 2) after long time of playing in 6channels mode, even without x-run.
> 
> p.s. My sblive works very well now, but my friends doesn't have sblive
> and they want working 6channels audio under linux on nforce2.
> 
> p.p.s. I may help with testing or finding a bug, but I need help. I new
> to alsa-driver and can't understand how it works, and can't find how
> snd_pcm_drop() implemented in i810 module.
> 
> 
Here is a simple speaker test program.
I nicely tests different speaker layout modes.

Read the readme.txt file that is with it on how to use it.
If you still get the problem with this simple program, it is certainly a 
bug in alsa.

See attached file.

Cheers
James


--------------030108030208010008020406
Content-Type: application/octet-stream;
 name="speaker_test.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="speaker_test.tar.bz2"

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
--------------030108030208010008020406--



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
