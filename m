From: Bruce Paterson <bruce@tele-ip.com>
Subject: Re: Plea to help save me from Windows !!!
Date: Thu, 21 Nov 2002 17:02:57 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DDC7711.1000804@tele-ip.com>
References: <3DDC2F86.70102@tele-ip.com> <1037844408.18971.12.camel@saturn>
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
To: Daniel Haus <daniel.haus@vizarts.de>
Cc: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Thanks for your reply Daniel.

Daniel Haus wrote:
>>Behaviour:
>>The output sound is perfect for about 2 minutes. After that every now 
>>and then I get "distortion" in the audio. No xruns or errors are 
>>reported in the software. It sounds like only part of the output buffer 
>>is correct (the general gist is right, but there's crap and warbles 
>>there as well).
> 
> 
> this might not be caused by your app, this could be an alsa-problem.

The reason I thought it was my app was playing wave files over & over 
using aplay didn't result in the problem. It's possible aplay is using 
the interface in a different way (for instance I'd imagine it uses the 
plughw interface).
It's a scientific application that cannot allow distortion, or even 
xruns to occur at all (every sample is critical).

> i experienced such problems, too (i am using cs46xx). usually i am
> runnigng xmms (with alsa-plugin) when it happens. i get a very "thin" 
> sound - very little bass, volume goes down and i get some distortion.
> alltogether it sounds like my speakers would be broken (they aren't,
> really!).
> i did not do any more testing, but about 24 hours ago i upgraded to
> 0.9.0-rc6 and had no problems since then, but that might not mean
> anything ...

I didn't even know there was an rc6 !  Normally they get announced on 
the list. Must have missed it.
Can anyone in the know shed some light as to whether rc6 changes are 
likely to help ?
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
