From: "John wr" <john_wr@hotmail.com>
Subject: RE: Re: [Alsa-user] terratec 7.1 audigy space
Date: Tue, 21 Dec 2004 20:29:21 +1100
Message-ID: <BAY17-F16823D12A23C72EE7D80CA96A30@phx.gbl>
References: <41C761FF.9070405@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <41C761FF.9070405@cfl.rr.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Try upgrading to alsa-driver 1.0.7.

I was very dissapointed with Mandrake 10.1 using alsa 1.0.6 and the 7.1 
space.  From my vauge recollection I could only get front sound, and capture 
did not work.  That was only slightly better than other distros that I have 
tried previously to get sound from my card.

I upgraded to alsa-driver-1.0.7 and it worked great on 6 channels and 
capture as well.  I did not even try to install the alsa-lib-1.0.7 due to a 
previous nightmare experience installing alsa onto Mandrake 10.0.

regards,
John.





>From: Rick B <zajelo3@cfl.rr.com>
>To: Stefan Kombrink <katakombi@web.de>
>CC: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
>Subject: [Alsa-devel] Re: [Alsa-user] terratec 7.1 audigy space
>Date: Mon, 20 Dec 2004 18:36:31 -0500
>
>Stefan Kombrink wrote:
>
>>Hello there,
>>
>>  Regarding to 
>>http://alsa.opensrc.org/index.php?page=Alsa+Preferred+Soundcards
>>I bought a Terratec 7.1 audigy space and installed it on a debian sarge 
>>with
>>kernel 2.4.27 and alsa 1.0.6.
>>
>>The module is loaded properly, and alsamixer seem to handle the card very 
>>well.
>>But I can't get any output, neither on "rear" nor on "front" or "center 
>>lfe".
>>Recording gives a straight wave form as well.
>>I found out that aplay hangs infinitely unless the wav sample is 48kHz 
>>S32_LE.
>>In that case aplay terminates successfully although no output is generated 
>>anyways.
>>
>>I haven't had the possibility to try the card under Win yet.
>>What's more likely?
>>An Alsa problem or an malfunctional hardware?
>>
>>any help is appreciated,
>>  Stefan K. >8^)
>>
>>
>>-------------------------------------------------------
>>SF email is sponsored by - The IT Product Guide
>>Read honest & candid reviews on hundreds of IT Products from real users.
>>Discover which products truly live up to the hype. Start reading now. 
>>http://productguide.itmanagersjournal.com/
>>_______________________________________________
>>Alsa-user mailing list
>>Alsa-user@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/alsa-user
>>
>>
>>
>I would think it was an alsa configuration problem first, as others have 
>reported some problems, on Debian, as well. Here's a link on how to setup 
>alsa on Debian:
>
>http://www.sonic.net/~rknop/linux/debian_alsa.html
>
>                   Rick B
>
>
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from real users.
>Discover which products truly live up to the hype. Start reading now. 
>http://productguide.itmanagersjournal.com/
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
