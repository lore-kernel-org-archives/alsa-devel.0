From: Rick B <zajelo3@cfl.rr.com>
Subject: Re: [Alsa-user] External input doesn't work
Date: Mon, 20 Dec 2004 16:27:25 -0500
Message-ID: <41C743BD.4020306@cfl.rr.com>
References: <200412180017.39649.ham.weebers@hccnet.nl> <200412180932.11234.ketelaars@wanadoo.nl> <1103360054.16168.9.camel@krustophenia.net> <s5hk6rcvni9.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk6rcvni9.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>At Sat, 18 Dec 2004 03:54:14 -0500,
>Lee Revell wrote:
>  
>
>>On Sat, 2004-12-18 at 09:32 +0100, Frans Ketelaars wrote:
>>    
>>
>>>The i810_audio module is an OSS module and interferes with ALSA.
>>>      
>>>
>>This keeps coming up over and over.  Isn't there some way we can at
>>least print an obvious warning if someone tries to load the OSS and ALSA
>>module for the same device?
>>    
>>
>
>I guess this isn't the culprit.  On 2.6 kernels, the modules can stay
>even if the probe fails because of PCI hotplug.  So, i810_audio can't
>obscure snd-intel8x0 driver.   (Yes, there was a bug in i810_audio,
>ignoring the error from request_* functions, but it was fixed
>meanwhile.)
>
>My wild guess is a mixer configuration problem as usual.
>
>
>Takashi
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
So the i810_audio module and the snd-intel8x0 module can be loaded at 
the same time? Would the below work?

*soundcore               6404   2  [i810_audio snd]*


                   Rick B


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
