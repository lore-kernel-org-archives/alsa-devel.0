From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: USB Audio/Midiman - partial success
Date: Fri, 13 Sep 2002 07:34:09 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D811661.3080701@boosthardware.com>
References: <s5hn0qryq08.wl@alsa2.suse.de>	<Pine.HPX.4.33n.0209100853400.12586-100000@studcom.urz.uni-halle.de> <s5h65xbp6n2.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 10 Sep 2002 10:58:34 +0200 (METDST),
> Clemens Ladisch wrote:
> 
>>>>The two PCM devices cannot be used at the same time anyway, so I think
>>>>creating a quirk for interface 0 which says "ignore this" could work.
>>>>Takashi, any comments?
>>>
>>>i think implementing a semaphore (or flag) for each endpoint would be
>>>better, so that the driver can find generally double-endpoints
>>>problem.
>>
>>I cannot imagine anybody else would be stupid enough to design a device
>>with double endpoints. But then I didn't imagine Midiman would, either.
>>Oh well, Murphy's Law ...  :-(
> 
> 
> since many (at least plural :) devices have this problem, i changed
> the usbaudio code slightly.  now a pcm stream is created per endpoint
> instead of interface.
> 
> on this version, m-audio's device should have one (for duo) or two
> (for quattro) pcm devices.
> 
> please let me know if any problems arise with this change.
> 

Now you definitely deserve a medal. A preliminary test with jack 
provides crystal clear sound.

You da man You da muthafucken man. Please pat yourself on the back from me.

Now I have 2 streams in /proc/asound/card2/

The final test is getting all four channels to play and record at the 
same time. If we can do that using ALSA all other platforms can eat our 
dust. From my tests before this breakthrough it seemed possible.





-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================

"Um...symbol_get and symbol_put... They're
kindof like does anyone remember like get_symbol
and put_symbol I think we used to have..."
- Rusty Russell in his talk on the module subsystem



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
