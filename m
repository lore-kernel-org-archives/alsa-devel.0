From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Avoiding xruns... was Re: smix plugin available?
Date: Thu, 28 Nov 2002 01:03:14 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DE4D0A2.8070801@superbug.demon.co.uk>
References: <1038405126.2021588.0@newmx2.fast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1038405126.2021588.0@newmx2.fast.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:

>>I am currently taking the following approach: -
>>Always prepare 2 audio hardware periods of sample frames in advance 
>>inside the user app.
>>
>>1) snd_pcm_wait()
>>2) write()
>>3) prepare new sample frames, then go back to (1).
>>    
>>
>
>for lower latency, you'd do:
>
> 1) snd_pcm_wait()
> 2) prepare new sample frames
> 3) write(), then go back to (1).
>
>but for the kinds of things you are describing, your original order
>seems OK.
>
>--p
>
>  
>
I suppose it depends on what latency we are measuring.
My first concern is avoiding xruns, and preparing new sample frames 
takes quite a lot of time.
For my application, it does not really matter how long it takes for the 
samples to reach the speakers, it is just that we have to know very 
accurately how long it is in fact taking. (so we use the delay() function.)
The other issue is the avoiding of xruns, so I think my suggestion is 
better than yours for xrun avoidance.

Cheers
James




-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
