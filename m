From: Francisco Moraes <fmoraes74@netzero.net>
Subject: Re: Help with supporting Emu10k1x  and question
Date: Mon, 23 Feb 2004 18:58:25 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <403A93A1.8050509@netzero.net>
References: <AABADU9R6AU6ULBA@mx06.nyc.untd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <AABADU9R6AU6ULBA@mx06.nyc.untd.com>
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


>> From what I can see for the emu10k1x (aka. sb Live 5.1 from Dell) is 
>>almost exactly the same as the Audigy LS.
>>
>>It is a very simple device, and the driver should be based more like the 
>>  snd-intel8x0 driver than the snd-emu10k1 driver.
>>It has no dsp, and no hardware mixing, and is a single open device. 
>>Very similar to the intel8x0 feature wise.
>>
>>If someone will send me a sample sound card, I will get it working.
>>    
>>
>
>Do you have any information about this hardware? Datasheet or sources or 
>something else? I am very interested.
>  
>
No datasheets, source or anything else as far as I know. Just us trying 
to reverse engineer it. I've made several changes to the emu10k1 driver 
trying to get PCM working, but I am missing something. Hopefully it will 
be something simple and I will have PCM playback working.

Francisco



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
