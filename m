From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: Alsa handling of spdif bits (was Re: Questions to
 HDSP users)
Date: Fri, 06 Feb 2004 20:12:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4023E72C.5040904@undata.org>
References: <f87b1d8ca44251034e552d245dd4da21@essej.net>	<402378E0.2060708@undata.org>	<s5hbroc8lvi.wl@alsa2.suse.de>	<4023932E.3090107@undata.org> <s5h7jz08hak.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from satellite.undata.org (brln-d514866b.pool.mediaWays.net [213.20.134.107])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA09926
	for <alsa-devel@alsa-project.org>; Fri, 6 Feb 2004 20:27:44 +0100
In-Reply-To: <s5h7jz08hak.wl@alsa2.suse.de>
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

> At Fri, 06 Feb 2004 14:14:22 +0100,
> Thomas Charbonnel wrote:
> 
>>>>The problem I see and I dislike with this is that iec bits are 
>>>>associated with playback. This is probably fine with most devices, but 
>>>>not with hardware that can do hardware routing, where you may want to 
>>>>route signal through the S/PDIF out with a certain bit combination - no 
>>>>playback is involved here. I believe a generic iec bits handling 
>>>>interface is a good thing, but is should not be affected by the card's 
>>>>status. Any comment on this Takashi ?
>>>
>>>
>>>well, in that case, the put callback of "IEC958 Playback Default"
>>>should change the corresponding register value immediately, too.
>>>
>>
>>Ok, but it seems this can't be done with iecset,
> 
> 
> hmm?  iecset will read/change "IEC958 Playback Default" (searching
> both MIXER and PCM interfaces).
> it doesn't change "IEC958 Playback PCM Stream", though.
>

Ok, sorry, it took me some time to get it. The problem then is that the 
hdsp driver does not implement this the proper way at the moment (and it 
should be broken also for rme9652 cards because the code comes from 
there). I will fix that soon.

> 
>> so I'm back with my 
>>question concerning amixer : all the 'value' fields of IEC ctls show a 
>>question mark. Is this a problem with the driver ? If not what would be 
>>the syntax to access those ctls ?
> 
> 
> amixer doesn't handle IEC958 status properly.
> 
> 

IIUC, this ctl is supposed to be used for example by DVD playing 
applications so that the fact they may temporary require the Non-Audio 
bit to be set for AC3 passthru does not interfere with the user settings ?
If so I'll keep this ctl and implement it properly.

Anyway thanks for clarifying, it was much needed :)
Thomas




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
