From: Bruce Paterson <bruce@tele-ip.com>
Subject: Re: Underruns (borken pipes)
Date: Tue, 16 Jul 2002 18:43:46 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D33DCC2.2D23591@tele-ip.com>
References: <20020715175552.982741F343@thorin.martin.com.au>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> 
> >OK. I believe I now understand the tradeoffs. Also, it was not clear
> >to me that the Jack audio driver would solve my problems since most
> >of what Jack is about is allowing multiple audio clients (which I
> >don't have, and in fact don't want at all in this case).
> 
> Thats not entirely true. At least 30-50% of JACK's design comes from
> the desire to have a simple, highly abstracted, highly efficient model
> for audio i/o. 95%+ of the time that i use JACK, its with one client
> (for now, anyway).

ok. 
[Might be worth doing a re-visit to your intro to Jack...add a line
about
the above.] 

> no, poll reports back to you when the amount of data/space equals or
> exceeds the "avail_min" count set by your program.

AHHHHHHHHHH !!!!!  Click ! :-)

It now works fine with polling once I set the avail_min to 1/8 the max
size of 
the frame buffer. 
Since it's working fine I'll leave it for now, but if we need to support
diff.
soundcards etc. in the future Jack may be worth a visit.

-- 
Cheers,
Bruce
-------------------------------------------------------------------
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom
they are addressed. If you have received this email in error please
notify the system manager.

    /\\\/\\\/\\\    /   /      Bruce Paterson          
   /  \\\ \\\ \\\  /   /    Senior Design Engineer
  /   /\\\/\\\/\\\/   /   87 Peters Ave, Mulgrave, Vic, 3170
 /   /  \\\ \\\ \\\  /  PO Box 4112, Mulgrave, Vic, 3170, Australia
/   /    \\\/\\\ \\\/   Ph: +61 3 8561 4232   Fax: +61 3 9560 9055
      Tele-IP Ltd.      Email: bruce@tele-ip.com    Icq: #32015991
                        WWW:   http://www.tele-ip.com       VK3TJN
-------------------------------------------------------------------


-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
