From: Dino Puller <dino@e4a.it>
Subject: Re: Surround example?
Date: Sat, 19 Nov 2005 10:26:14 +0100
Message-ID: <437EEFB6.6010801@e4a.it>
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



-------- Original Message --------
Subject: 	Re: [Alsa-devel] Surround example?
Date: 	Sat, 19 Nov 2005 10:25:34 +0100
From: 	Dino Puller <dino@e4a.it>
To: 	Takashi Iwai <tiwai@suse.de>
References: 	<437CFAE5.5080908@e4a.it> <437DC4D3.3050900@e4a.it> 
<s5hoe4ip00t.wl%tiwai@suse.de> <437DDD5E.8060405@e4a.it> 
<s5hlkzmoxxm.wl%tiwai@suse.de>



Takashi Iwai wrote:

>At Fri, 18 Nov 2005 14:55:42 +0100,
>Dino Puller wrote:
>  
>
>>Takashi Iwai wrote:
>>
>>    
>>
>>>At Fri, 18 Nov 2005 13:10:59 +0100,
>>>Dino Puller wrote:
>>> 
>>>
>>>      
>>>
>>>>Dino Puller wrote:
>>>>
>>>>   
>>>>
>>>>        
>>>>
>>>>>Hi all,
>>>>>  i'd like to code a surround player, but i haven't found any 
>>>>>documentation about it, can you give me a link to a tutorial or an 
>>>>>example or something?
>>>>>
>>>>>Thanks,
>>>>> Dino Puller
>>>>>
>>>>>
>>>>>     
>>>>>
>>>>>          
>>>>>
>>>>Ok now i've opened my surrond40 device but now what i have to change to 
>>>>my snd_pcm_mmap_begin/snd_pcm_mmap_commit routine? Actully i can hear 
>>>>noise only from front channels.
>>>>   
>>>>
>>>>        
>>>>
>>>Are you using 1.0.10-final?
>>>
>>>
>>>Takashi
>>>
>>> 
>>>
>>>      
>>>
>>No  i'm using default alsalib that come with debian sid: 1.0.9
>>are there any improvement or issue in 1.0.10 ?
>>    
>>
>
>Yes.
>
>
>Takashi
>
>
>  
>
Hmm i'm looking to pcm.c example but when i lunch
#./pcm -Dsurround40 -c4 -mdirect_interleaved
I obtain:

Access type not available for playback: Invalid argument
Setting of hwparams failed: Invalid argument

And direct mmap interleaved is the method i want to implement. So pcm.c 
isn't a good example for my purpose? Any Documentation?

thanks,
  Dino






-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
