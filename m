From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: Trivial hdsp.c patch to support rev 50 cards
Date: Mon, 28 Jul 2003 08:16:38 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGGEIACNAB.mknecht@controlnet.com>
References: <E19h8y1-0003Mu-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <E19h8y1-0003Mu-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
> >This adds rev 50 to the list of supported cards.
>
> i will have a slightly longer patch that includes this, later
> today. also included will be a "no_mixer" option for the hdsp9652.
>
> --p
>

Paul,
   Is this envisioned an option in modules.conf, or a compile time option?

   Also, while I have your attention, can you clarify whether the RME
Hammerfall 9652 and 9636 have mixers? I made one of my 9636 machines into
dual boot last evening and then found alsamixer didn't work. I assume that
means the 9636 has no mixer, or is this a bug I should be reporting
somewhere?

Thanks,
Mark




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
