From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: buffer sizes
Date: Thu, 28 Nov 2002 09:29:37 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18HPbv-0008W2-00@sc8-sf-list1.sourceforge.net>
References: <200211280856.56500.mark@WebServiceSolutions.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 28 Nov 2002 08:56:55 EST."
             <200211280856.56500.mark@WebServiceSolutions.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Swanson <mark@WebServiceSolutions.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> its also worth noting that it too is not immune from missing xruns,
>> but there isn't anything we can do about kernel/driver code that
>> blocks interrupts for an entire buffer :(
>
>I do not know how long an entire buffer is. I assume this will differ per 
>card, but how small could the worst-case possibly be?

the software gets to configure it. typical values range from 128
frames to 8192 frames, so at 48kHz, that would be 2.6ms to 170ms.

--p


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
