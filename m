From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: recording problems with snd-cs46xx (was: Re: Re:
 Alsa-devel digest, Vol 1 #810 - 3 msgs)
Date: Tue, 11 Nov 2003 22:26:53 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0311112221120.32192-100000@ecabase.localdomain>
References: <20021030000513.GG15048@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021030000513.GG15048@draal.physics.wisc.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bob McElrath <bob+alsa-devel@mcelrath.org>
Cc: Benny Sjostrand <gorm@cucumelo.org>, Peter Heatwole <peter599@gotnet.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

this issue is over a year old, but in case someone stumbles on
to the same problem. The solution is already documented at

   http://alsa.opensrc.org/index.php?page=cs46xx

... but it took me a while to find it. :)

On Tue, 29 Oct 2002, Bob McElrath wrote:

>>>Recording still seems to not work.  I still get about a 1Hz ticking in
> I cannot record anything at all, from any input (I haven't tried from
> SPDIF -- I don't have a reliable SPDIF source anyway)  I get the 1Hz

I had this very same problem with alsa-driver-0.9.8. The problem turned 
out to be that I had not selected 'ADC' as a capture source in alsamixer. 
So you need to select all three: 'ADC', 'Mic' and 'Capture' for the 
recording to work properly.

PS Tested with IBM Thinkpad models T20 and T21.

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
