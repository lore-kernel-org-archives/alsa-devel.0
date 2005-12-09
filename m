From: Trevor Feeney <trev@feens.org>
Subject: Re: Re: Revo 5.1
Date: Fri, 09 Dec 2005 09:20:51 -0500
Message-ID: <439992C3.6010604@feens.org>
References: <43948A9F.6020009@feens.org>	<43948F9E.50407@seznam.cz>	<4395A188.7060307@feens.org>	<s5hu0dmjn6f.wl%tiwai@suse.de>	<43989AC8.1020203@seznam.cz> <s5hslt2zfy7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hslt2zfy7.wl%tiwai@suse.de>
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
Cc: David Peroutka <david.peroutka@seznam.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>At Thu, 08 Dec 2005 21:42:48 +0100,
>David Peroutka wrote:
>  
>
>>Takashi Iwai wrote:
>>    
>>
>>>At Tue, 06 Dec 2005 09:34:48 -0500,
>>>Trevor Feeney wrote:
>>>
>>>      
>>>
>>>>Was taking a look at the source for the Revo 5.1, noticed a few things.  
>>>>You set it up as using only 6 DACs, going by the 5.1 I figure, but when 
>>>>you consider that it also has the headpone out, it would have the same 
>>>>number of DACs as the 7.1 (8 DACs in all). 
>>>>
>>>>Takashi - that answers your question in the last thread...from what I've 
>>>>read, the 5.1 only uses one codec, and the headphones would just be a 
>>>>separate channel.  I tried adjusting the number of DACs to 8 in the 
>>>>driver, and did manage to get two
>>>>DAC mixer sliders.  I'm not really sure if that was the way to go or 
>>>>not.  I tried adjusting the asound plugin to output to 8 channels, pcm 
>>>>device surround71, but that didn't seem to work.  I wondering if it 
>>>>needs to be setup separately thant the other 6 channels so that it would 
>>>>be considered it's own PCM device.  That goes a bit beyond my realm of 
>>>>knowledge for driver development though...still trying to learn this.  
>>>>Been reading a lot of the documents and such.
>>>>        
>>>>
>>>[Added alsa-devel ML again]
>>>
>>>In the case of ice1724, you can open a stereo stream separately.
>>>The first PCM is assigned to the multi-channel, i.e. 2-8 channels
>>>interleaved format.  The secondary PCM is for SPDIF.  The third PCM is
>>>the "independent" streams.  This may have up to 3 substreams, each of
>>>which is a 2-channel one.  If you change num_dacs = 8, you'll be able
>>>to access plughw:0,2,3 (suppose the card# is 0) for the last two
>>>channels individually:
>>>
>>>	% aplay -Dplughw:0,1,3 foo.wav
>>>
>>>And you have to raise the corresponding DAC mixer values, of course.
>>>
>>>
>>>Takashi
>>>      
>>>
>>I've enabled all 8-channels of AK4358 in the driver, but I was unable to 
>>access the 4-th substream, because (as you noted) there are max 3 
>>substreams per PCM, so "plughw:0,2,3" is actually not available (the 
>>other substreams work fine).
>>    
>>
>
>My bad, I mean 'plughw:0,2,2'.
>
>But Trevor reported it doesn't work, too, and mentioned that the chip
>itself (Envy24GT) shouldn't support 4th stream...
>
>
>Takashi
>  
>
Takashi,

I've been poking around in the source for the driver and have a few 
questions.  Where is it in the code that the front PCM stream would 
conncect to output to the DACs associated with that, and is there a way 
to duplicate that to the extra 2 DACs?  I know that laptop cards tend to 
have a similar setup, outputting to headphones and speakers, so I figure 
it can be done.  I'm also thinking that's the most logical solution in 
this case as well.

I have no problem fooling around to figure things out (I went to school 
for software engineering, just have never dealt with drivers before), I 
just need to be pointed in the right direction.  I know there are a few 
people now looking for support with this card, so I figure if we work 
together we can get it all working.

Thanks again,

Trevor


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
