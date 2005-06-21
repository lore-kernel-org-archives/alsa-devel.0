From: Anssi Hannula <anssi.hannula@mbnet.fi>
Subject: Re: [PATCH] Change the freq limit of speaker-test
Date: Tue, 21 Jun 2005 18:14:55 +0300
Message-ID: <42B82EEF.3020401@mbnet.fi>
References: <42B31318.1020705@mbnet.fi>	<s5hzmtknf95.wl%tiwai@suse.de>	<42B8293C.1060205@mbnet.fi> <s5hpsufoigm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hpsufoigm.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 21 Jun 2005 17:50:36 +0300,
> Anssi Hannula wrote:
> 
>>Takashi Iwai wrote:
>>
>>>At Fri, 17 Jun 2005 21:14:48 +0300,
>>>Anssi Hannula wrote:
>>>
>>>>I noticed that the speaker-test has limited sine wave frequency to 
>>>>50-5000 Hz. Attached patch changes that to 0-24575Hz (that's the limit 
>>>>at least here (x86-64) after which the freq would roll over to 0 Hz).
>>>
>>>Does freq=0 really work?  I think this will result in zero-division.
>>
>>Well, it produces the expected output (no sound) and does not crash.
> 
> Strange.  Anyway, accepting freq = 0 doesn't make sense.
> I think we should keep reasonalbe minimal/maximal values to produce
> tones.

I understand that 0 doesn't make any sense.
But I think we should still change the limits, so that users can 
experiment things and test their hardware (someone asked for tone 
generator in VDR ml, I replied with speaker-test, but it didn't produce 
high enough tones) etc, and it wouldn't hurt.

-- 
Anssi Hannula



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
