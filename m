From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: Re: emu10k1: rear mono played on all exept rear
Date: Wed, 16 Feb 2005 21:40:36 +0100
Message-ID: <4213AFC4.7050501@glocalnet.net>
References: <42132C58.3050006@glocalnet.net> <1108584134.29298.19.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108584134.29298.19.camel@krustophenia.net>
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

Lee Revell wrote:
> On Wed, 2005-02-16 at 12:19 +0100, Mikael Magnusson wrote:
> 
>>I discovered a bug in EMU10K1.pcm.rear.0 in EMU10K1.conf. It sends rear 
>>mono output to FX 0 and 1 instead of FX 2 and 3!
>>
>>/Mikael Magnusson
>>
>>--- cvs/alsa/alsa-lib/src/conf/cards/EMU10K1.conf      2004-07-13 
>>19:32:18.000000000 +0200
>>+++ /usr/share/alsa/cards/EMU10K1.conf  2005-02-16 11:56:24.000000000 +0100
>>@@ -41,7 +41,7 @@
>>                                 name "EMU10K1 PCM Send Volume"
>>                                 index { @func private_pcm_subdevice }
>>                                 lock true
>>-                               value [ 255 255 0 0 0 0 255 0 0 0 0 255 ]
>>+                               value [ 0 0 255 255 0 0 255 0 0 0 0 255 ]
>>                         }
>>                 ]
>>         }
>>
> 
> 
> This seems wrong to me.  Isn't the correct fix to do this:
> 
> {
>       name "EMU10K1 PCM Send Volume"
>       index { @func private_pcm_subdevice }
>       lock true
>       value [ 255 255 0 0 255 0 0 0 0 255 0 0 ]
> }
> {
>       name "EMU10K1 PCM Send Routing"
>       index { @func private_pcm_subdevice }
>       lock true
>       value [ 2 3 0 0 2 3 0 0 2 3 0 0 ]
> }
> 
> The current config relies on the 3rd and 4th FX sends being set to FX 2
> and 3.  It seems better to state this explicitly.
> 
> Lee
> 

Maybe, but it isn't explicit in Audigy.conf, Audigy2.conf either.

/Mikael Magnusson


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
