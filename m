From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: Audigy SB0090 identification patch
Date: Sat, 02 Apr 2005 09:57:57 +0200
Message-ID: <424E5085.5060708@pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Not this patch, but this one:

http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/include/emu10k1.h?r1=1.62&r2=1.63 <http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/include/emu10k1.h?r1=1.62&r2=1.63>


---> unsigned int card;

Copy of emu10k1.h in alsa-lib should be in sync with emu10k1.h in kernel.

Peter Zubaj

/>I'm not sure if anyone is aware that with this patch installed, it
/breaks 
/>ld10k1. I get the following errors when trying to load it: 
>
>Error: unable to get info
>Error: error in main loop
>
>Peace/



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
