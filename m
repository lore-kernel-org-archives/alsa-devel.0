From: Rick B <zajelo3@cfl.rr.com>
Subject: Re: terratec 7.1 audigy space
Date: Mon, 20 Dec 2004 18:36:31 -0500
Message-ID: <41C761FF.9070405@cfl.rr.com>
References: <200412202318.19650.katakombi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <200412202318.19650.katakombi@web.de>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Stefan Kombrink <katakombi@web.de>
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Stefan Kombrink wrote:

>Hello there,
>
>  Regarding to 
>http://alsa.opensrc.org/index.php?page=Alsa+Preferred+Soundcards
>I bought a Terratec 7.1 audigy space and installed it on a debian sarge with
>kernel 2.4.27 and alsa 1.0.6.
>
>The module is loaded properly, and alsamixer seem to handle the card very 
>well.
>But I can't get any output, neither on "rear" nor on "front" or "center lfe".
>Recording gives a straight wave form as well.
>I found out that aplay hangs infinitely unless the wav sample is 48kHz S32_LE.
>In that case aplay terminates successfully although no output is generated 
>anyways.
>
>I haven't had the possibility to try the card under Win yet.
>What's more likely?
>An Alsa problem or an malfunctional hardware?
>
> any help is appreciated,
>  Stefan K. >8^)
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from real users.
>Discover which products truly live up to the hype. Start reading now. 
>http://productguide.itmanagersjournal.com/
>_______________________________________________
>Alsa-user mailing list
>Alsa-user@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-user
>
>  
>
I would think it was an alsa configuration problem first, as others have 
reported some problems, on Debian, as well. Here's a link on how to 
setup alsa on Debian:

http://www.sonic.net/~rknop/linux/debian_alsa.html

                   Rick B

                 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
