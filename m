From: Roger Williams <raw@qux.com>
Subject: Re: hdsp multiface pci.
Date: 20 Jan 2003 01:44:01 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m3u1g4iamm.fsf@grouper.coelacanth.com>
References: <3E2A952E.6060305@boosthardware.com>
	<1042985569.1663.33.camel@satellite.undata.org>
	<3E2AC45F.3070601@boosthardware.com>
	<1042992464.1649.55.camel@satellite.undata.org>
	<3E2AD34D.6070308@boosthardware.com>
	<m3d6mt9is6.fsf@grouper.coelacanth.com>
	<1042978893.1341.108.camel@Godzilla>
	<m3ptqskcay.fsf@grouper.coelacanth.com>
	<1042994069.1162.33.camel@Godzilla>
	<m3bs2ck1o3.fsf@grouper.coelacanth.com>
	<1043006386.1401.60.camel@Godzilla>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1043006386.1401.60.camel@Godzilla>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@attbi.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Mark, have you looked at the block diagrams of the HDSP mixer in the
HDSP manuals, or read the technical overview of the HDSP mixer
hardware at http://www.rme-audio.de/english/techinfo/hdsp_tmhard.htm ?

They provide a fairly clear picture of what the hardware can do; but
it doesn't map exactly to the amixer behaviour I see.  Specifically, I
haven't figured out how to adjust the output faders (between each
output and its dedicated buss) or the input pans (each input is shown
as driving a pair of busses through a fader and a pan, rather than
through two independent faders).

Perhaps Thomas knows all the details of this?

-- 
Roger Williams <raw@qux.com>
Qux Tool & Die, Middleborough, Massachusetts
// Omne tulit punctum qui misquit utile dulci //


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
