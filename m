From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: USB Audio/Midiman - partial success
Date: Tue, 10 Sep 2002 22:41:49 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D7DF69D.8080209@boosthardware.com>
References: <s5hn0qryq08.wl@alsa2.suse.de>	<Pine.HPX.4.33n.0209100853400.12586-100000@studcom.urz.uni-halle.de> <s5helc2yopz.wl@alsa2.suse.de>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
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
> I found that M-Audio quattro has the same problem.
> the same endpoints are shared among different interfaces.  sigh...
> 

I think a possible reason for this in the quattro is to ensure that 
customers eventually have to upgrade to a next gen device. From what I 
remember the win drivers will only allow stereo i/o at 96Khz. Even 
though it has 4 channels or 2 stereo devices.

If there was a Midiman rep on this list they could rebute that ;P



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
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
