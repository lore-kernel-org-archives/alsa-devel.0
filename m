From: Bruce Paterson <bruce@tele-ip.com>
Subject: Re: non-interleaved and interleaved access
Date: Tue, 10 Dec 2002 11:29:11 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DF53557.8070708@tele-ip.com>
References: <Pine.LNX.4.21.0212092258200.768-100000@summer.quitte>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: Tim Goetze <tim@quitte.de>
Cc: nick <nixx@nixx.org.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Tim Goetze wrote:
> nick wrote:
> 
> 
>>is this because of the cards or my code?
> 
> 
> it's the hardware -- all hw i know of is hard-wired for one
> of the two access types. interleaved is much more common.

I'll try and reply to this based on my experience, but I'm sure others 
can correct me !
Yes interleaved is more common on the hardware, and if you talk directly 
to the hw:0.0 interface this is all you can use.
If you use the plughw:0.0 interface, however, you can use interleaved or 
non-interleaved as the plug code modifies whatever you set to suit the 
hardware (including sizing and bit-rates).
I couldn't get the plughw interface to do this for ice1712, however (it 
simply didn't work), but this was with quite an early release of 0.9 
(rc2) and things may well have improved by now. Since then my 
application chnaged to use hw:0.0 directly so I haven't gone back to 
check....


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
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
