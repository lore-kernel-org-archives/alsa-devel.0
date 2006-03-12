From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Dreamcast AICA driver
Date: Sun, 12 Mar 2006 20:23:14 +0000
Message-ID: <1142194994.19034.9.camel@localhost.localdomain>
References: <1142124747.9496.50.camel@localhost.localdomain>
	 <1142125920.25358.22.camel@mindpipe>
	 <1142126427.9496.56.camel@localhost.localdomain>
	 <1142145536.25358.116.camel@mindpipe>
	 <1142195736.8342.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1142195736.8342.4.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Manuel Jander <manuel.jander@gmail.com>
Cc: Alsa-devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-03-12 at 21:35 +0100, Manuel Jander wrote:
> Hi,
> 
> On Sun, 2006-03-12 at 01:38 -0500, Lee Revell wrote:
> > On Sun, 2006-03-12 at 01:20 +0000, Adrian McMenamin wrote:
> > > > > http://newgolddream.dyndns.info/cgi-bin/cvsweb
> > > > > 
> > > 
> > 
> > > 	dreamcastcard->clicks++;
> > > 	if (dreamcastcard->clicks == 8) dreamcastcard->clicks = 0;
> > 
> > dreamcastcard->clicks %= 8;
> 
> Watch out. The ARM7 does not support this in direct assembler. If the
> compiler is not smart enough it would require a division, and that is
> really realy slow on a any ARM processor. 
> Helping the compiler by using
> 
> dreamcastcard->clicks &= 0x00000003;
> 
> ... would be a much faster option. 
> 
This was actually in SH4 code rather than ARM7, though I did have some
fun and games with the ARM7 code - seemingly with division :)



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
