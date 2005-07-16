From: Lars Heineken <Lars.Heineken@gmx.de>
Subject: Re: DMixer
Date: Sat, 16 Jul 2005 13:09:18 +0200
Message-ID: <42D8EADE.4080205@gmx.de>
References: <20050715161901.90015.qmail@web30713.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (pop.gmx.de [213.165.64.20])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 7DC0D14F
	for <alsa-devel@alsa-project.org>; Sat, 16 Jul 2005 13:09:29 +0200 (MEST)
In-Reply-To: <20050715161901.90015.qmail@web30713.mail.mud.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Suja,

I'm not 100 percent certain, but I would take a look at the "pcm_dmix_*"
files in the "src" folder of the alsa library. They contain generic and
optimized mixing code for different platforms.

Regards,

Lars.

SUJA JAMES wrote:

>Hi All,
>
>I am looking for a software based mixer
>implementation. Then,I came to know that ALSA has one
>DMIX. Please let me know from where I will get the
>source code for the same. I download the ALSA Driver
>and Lib-plugins 1.0.9. But I am unable to find out the
>source code. 
>
>Can any one pin point the exact source code
>location.(Not the mixer application, the Mixer
>implementation)
>
>Thanks,
>Suja.
>
>__________________________________________________
>Do You Yahoo!?
>Tired of spam?  Yahoo! Mail has the best spam protection around 
>http://mail.yahoo.com 
>
>
>-------------------------------------------------------
>SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
>from IBM. Find simple to follow Roadmaps, straightforward articles,
>informative Webcasts and more! Get everything you need to get up to
>speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>
>  
>




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
