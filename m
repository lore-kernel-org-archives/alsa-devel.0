From: Ludovic Drolez <ludovic.drolez@freealter.com>
Subject: oops with 2.4.22 alsa 0.9.8 and a non-pnp sb16 (more info)
Date: Sat, 08 Nov 2003 17:03:36 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FAD13D8.7040007@freealter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi !

In the logs from my last post, there were messages from the standard sb.o module:

isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
>> Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
>> sb: No ISAPnP cards found, trying standard ones...
>> SB 4.13 detected OK (220)

So I removed standard sound modules, and now when I modprobe snd-sb16 I only get:

isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found

So the other problem is that it's impossible to disable isa-pnp support with
alsa 0.9. The configure's option '--without-isapnp' does not work anymore !
(It worked with alsa 0.5).

So, I added an '#undef CONFIG_PNP' in sb16.c and now I get another oops when I
modprobe it.
It seems that SB's non-pnp detection code is completly broken ...



Cheers,

    Ludovic Drolez.











-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
