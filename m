From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: about bt878/879
Date: Wed, 30 Mar 2005 19:31:09 +0200
Message-ID: <424AE25D.7070000@pobox.sk>
References: <200503301056.j2UAuRHo012810@www4.pobox.sk> <7fe2059905033006087479f171@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <7fe2059905033006087479f171@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Joe Hsu <nagual.hsu@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Yes, they can. But 8000 Hz on bt878 or AC97 is not exactly 8000 HZ. It 
can be for example 8010 Hz for AC97 and 7990 for bt878. Only high end 
sound card can be synchronized together. For your case, you should 
handle this situation for example by discarding or inserting some samples.

Peter Zubaj

Joe Hsu wrote:

>Well.....I believe the AC97 alsa driver can operate at 8000 HZ in
>software level.
>
>
>On Wed, 30 Mar 2005 12:56:27 +0200, Peter Zubaj <pzad@pobox.sk> wrote:
>  
>
>>Hi,
>>
>>Just blind shot: Maybe diffrence in crystal frequence. 8000 Hz on
>>bt878 is not 8000 Hz on AC97.
>>
>>Peter Zubaj
>>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
