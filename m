From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: Alsa handling of spdif bits (was Re: Questions to
 HDSP users)
Date: Fri, 06 Feb 2004 14:14:22 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4023932E.3090107@undata.org>
References: <f87b1d8ca44251034e552d245dd4da21@essej.net>	<402378E0.2060708@undata.org> <s5hbroc8lvi.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from satellite.undata.org (brln-d5148667.pool.mediaWays.net [213.20.134.103])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA31269
	for <alsa-devel@alsa-project.org>; Fri, 6 Feb 2004 14:18:53 +0100
In-Reply-To: <s5hbroc8lvi.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jesse Chappell <jesse@essej.net>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote :
> At Fri, 06 Feb 2004 12:22:08 +0100,
> Thomas Charbonnel wrote:
> 
>>(BTW Takashi iecset -h says 'audio on' is non-audio and 'audio off' is 
>>audio but it seems to be the other way round, unless the hdsp driver is 
>>wrong here...)
> 
> 
> yep, fixed now on CVS :)
> 
> 
>>The problem I see and I dislike with this is that iec bits are 
>>associated with playback. This is probably fine with most devices, but 
>>not with hardware that can do hardware routing, where you may want to 
>>route signal through the S/PDIF out with a certain bit combination - no 
>>playback is involved here. I believe a generic iec bits handling 
>>interface is a good thing, but is should not be affected by the card's 
>>status. Any comment on this Takashi ?
> 
> 
> well, in that case, the put callback of "IEC958 Playback Default"
> should change the corresponding register value immediately, too.
>

Ok, but it seems this can't be done with iecset, so I'm back with my 
question concerning amixer : all the 'value' fields of IEC ctls show a 
question mark. Is this a problem with the driver ? If not what would be 
the syntax to access those ctls ?

> 
> 
>>>An aside: this is also complicated because to open the device, the
>>>channels item in the slave.pcm section must match the iobox in
>>>use (multiface or digiface) which have differing channel counts.
>>>So when we do get this working, it will be a problem to handle
>>>both cases in a conf file.
>>>
>>
>>Not to mention that there is also a shift in the S/PDIF channels
>>position when the card changes speed mode...
>>Can the current configuration mechanism handle this properly ?
> 
> 
> when the channel position changes dynamically according to the certain
> state, it'd be difficult with the current config without addition...
>

In case you plan to implement those additions, let me know if there is 
anything to adapt on the driver side.

> 
>>Similarly we would need different .conf files for the different hdsp
>>cards, but seeing Takashi's patch, it seems .conf files are associated
>>with a card using the generic driver name (here 'H-DSP'). Is there a way
>>to affect a .conf file to a specific submodel ?
> 
> 
> the easiest way is to change the driver name per model.
> for example, emu10k1 driver provides "EMU10k1", "Audigy" and
> "Audigy2" according to the model.
> 

Ok, this will be part of the driver update I'm working on ATM.

Thomas




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
