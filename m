From: Apostolos Dimitromanolakis <apostolos@aei.ca>
Subject: Re: Re: [PATCH] aureon.c - hpamp, adc/dac mute
Date: Fri, 14 May 2004 17:43:40 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40A53D8C.9030201@aei.ca>
References: <40A4C012.8080004@gmx.at> <s5hn04bma09.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-7; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn04bma09.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, chris_web@gmx.at
List-Id: alsa-devel@alsa-project.org


Hm.. It seems then that after all that the Audiotrak Prodigy 7.1 is 
identical to Terratec Aureon, except that the later has optical digital 
IO instead of coaxial. The headphone function is also implemented in 
Audiotrak Prodigy 7.1 driver. I used to think that it was a difference 
between the Prodigy and Terratec Aureon. If everything else is the same 
(i.e. wiring inside the card) then we can  merge the two drivers into 
one since they are almost identical (prodigy.c and aureon.c).

I also have a dump from the communication of the windows driver with the 
AC97 codec of the card which is used for mixing the 4 internal 
connectors (the communication is through a XIlinx programmable device 
and so it was difficult to implement).  I believe that the dump can be 
used to add the support of the AC97 to both Prodigy and Aureon. I will 
do it sometime when I find time but if anyone is interested I can send 
the dump.

Cheers,
Apostolos


>At Fri, 14 May 2004 14:48:18 +0200,
>Christoph Haderer wrote:
>  
>
>>[1  <text/plain; us-ascii (7bit)>]
>>This patch adds a headphone amplifier control and the ability to mute 
>>the DAC (all channels at once) and the ADC channels. wm_adc_vol_put had 
>>to be changed a little bit because otherwise the ADC-mute bits would be 
>>overwritten when changing the ADC-gain. I have also modified 
>>wm_adc_mux_info; IMHO the *texts array was wrong before - the texts 
>>didn't match the recording source (tested with alsamixer).
>>This patch applies cleanly against the alsa source files that came with 
>>kernel 2.6.6-mm2.
>>    
>>
>
>  
>



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
