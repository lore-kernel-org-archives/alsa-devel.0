From: K.Fetscher@t-online.de (Klaus Fetscher)
Subject: Re: Driver Programming
Date: Sun, 28 Nov 2004 23:06:37 +0100
Message-ID: <41AA4BED.5040300@fetron.de>
References: <Pine.HPX.4.33n.0411261226040.3150-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0411261226040.3150-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>, Giuliano Pochini <pochini@shiny.it>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks Clemens and Giuliano for the answers !

>>I want to programm an driver for the Cirrus CS42516. This Codec
>>communicates with an ARM9 CPU over 3 I2S channels. I want to use 3
>>stereo channels for playing and two stereo channels for receiving the
>>data. All three channels are working with the same clock-rate.
>>
>>I have read the documentation "Writing an Alsa Driver" but I am confused
>>about the meaning of PCM Streams and Substreams. What must I declare,
>>one PCM Stream with three Substreams or 3 PCM Streams ?
>>    
>>
>How does your chip work ?  If I inderstood you correcty, it has three
>independent stereo outputs and two inputs.
>
>  
>
Yes, but all stereo channels must work with the same sampling rate.

>snd_pcm_new(chip->card, "name", DEV_0, THREE_OUT, TWO_IN, &pcm);
>
>If each substream can be either mono or stereo, in the
>.open() callback you'll set
>
>runtime->hw->channels_min = 1;
>runtime->hw->channels_max = 2;
>
>  
>
Okay, I am using these parameters for the function snd_pcm_new(  ).

Is it possible to detect (in the functions xxx_playback_prepare, 
xxx_capture_prepare ...), which substream will be used.
I need to know the number of the substream, because I have three FIFO's 
for transmitting and two FIFO's for receiving and I want to program a 
dedicated DMA-Controllers for every substream.

Is it possible, to select a substream with aplay ?


Thanks

Klaus



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
