From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: DXS volume as PCM on VIA82xx & CMI codecs
Date: Wed, 23 Feb 2005 11:00:39 +0100
Message-ID: <421C5447.8090009@gmx.de>
References: <s5hfyzotix9.wl@alsa2.suse.de>	<421BA9DC.6030604@gmx.de> <s5h3bvntxht.wl@alsa2.suse.de>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5h3bvntxht.wl@alsa2.suse.de>
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
> At Tue, 22 Feb 2005 22:53:32 +0100,
> thomas schorpp wrote:
> 
>>Takashi Iwai wrote:
>>
>>>Hi,
>>>
>>>the patch below is an experimental patch to use DXS volume controls
>>>for the missing PCM volume controls for C-Media codecs.  The DXS
>>>volume controls won't be created any more with this patch.
>>>
>>>Please let me know whether it works.
>>>
>>>
>>>Takashi
>>>
>>
>>yes it does, but the pcm mixer is only accessible from xmms oss-plugin 
>>not from alsa-plugin and balance doesnt work.
>>
>>hmm, access bug in xmms, xine does acces the new PCM slider.
>>
>>ok.
>>
>>how about balance? its on the master vol only, hm?
> 
> 
> Can't you change left/right PCM volume independently?
> 

yes, but only with alsamixergui or maybe the gnomemixer, not with suse's 
  preffered kde mixer kmix.

> 
> Takashi
> 

tom


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
