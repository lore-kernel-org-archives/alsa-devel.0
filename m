From: Bruce Paterson <bruce@tele-ip.com>
Subject: Re: Half Speed on rc6 ?
Date: Tue, 26 Nov 2002 11:41:44 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DE2C348.5040805@tele-ip.com>
References: <Pine.LNX.4.33.0211251302260.517-100000@pnote.perex-int.cz>
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
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Mon, 25 Nov 2002, Bruce Paterson wrote:
> 
>>>>>Behaviour:
>>>>>The output sound is perfect for about 2 minutes. After that every now 
>>>>>and then I get "distortion" in the audio. No xruns or errors are 
>>>>>reported in the software. It sounds like only part of the output 
>>>>>buffer is correct (the general gist is right, but there's crap and 
>>>>>warbles there as well).

>>I have now tried 0.9.0rc6 and something VERY weird has happened. 
>>Suddenly the sample rate appears to have halved. A previous 600Hz tone
>>now is 300Hz and everything takes twices the time to output.
>>Surely this is a bug that has crept in.

> This problem is fixed in CVS. Try the latest CVS snapshot or wait for rc7.

Thanks Jaroslav !  Any ideas about when rc7 might be released ? 
(determines if I go for CVS or not). Also, any ideas about my "sand" 
distortion problem ?  It's still happening after a period of time (seems 
to change in nature a bit with each release).
> 
> 						Jaroslav

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
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
