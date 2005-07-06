From: Colin Fletcher <colinf@axicon.com>
Subject: Re: [linux-usb-devel] Fw: BUG: Kernel panic when disconnecting
 Edirol USB2 audio interface
Date: Wed, 06 Jul 2005 19:24:08 +0100
Message-ID: <42CC21C8.10505@axicon.com>
References: <Pine.HPX.4.33n.0506280853210.5280-100000@studcom.urz.uni-halle.de>
Reply-To: colinf@axicon.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0506280853210.5280-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: linux-usb-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
>>>I'd like to know if playback and/or MIDI work.
>>
>>I don't have any MIDI hardware to hand at the moment: I can try to dig
>>out my old Roland drum machine next week if that will help.
> 
> 
> You could just use a MIDI cable for loopback.

I'm sorry it took me so long to find a MIDI cable... I've now tried 
this, and it seems to work (kernel 2.6.12.2 + the ALSA CVS from 
27/06/2005 that I was using before). I haven't stressed it: I just sent 
a few note on/note off events and continuous controllers to the "UA-1000 
MIDI" out, and saw that they came back in again. Is there anything more 
elaborate I should try?

Colin Fletcher

-- 




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
