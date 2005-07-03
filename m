From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: [Alsa-user] sound blaster name
Date: Sun, 03 Jul 2005 22:01:12 +0200
Message-ID: <42C84408.6080906@free.fr>
References: <42B3E474.7000301@free.fr> <42B3ECD5.6030500@superbug.co.uk>	 <42B3F28B.4030307@free.fr> <42B3F484.5060004@free.fr>	 <42B3F83C.90305@superbug.co.uk> <42B5A056.4010608@free.fr>	 <42BC6451.8020303@free.fr> <1119647048.3290.57.camel@mindpipe>	 <42C71EB1.1020207@free.fr> <42C722AD.1010603@superbug.co.uk>	 <42C7278C.5090100@free.fr> <42C7C7EF.9030201@free.fr>	 <42C7D322.1050100@superbug.co.uk>  <42C7E5C4.3030602@free.fr> <1120414451.7915.2.camel@mindpipe> <42C83388.4090804@free.fr> <42C842D3.90603@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42C842D3.90603@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> matthieu castet wrote:
> 
>>Lee Revell wrote:
>>
>>
>>>On Sun, 2005-07-03 at 15:19 +0200, matthieu castet wrote:
>>>
>>>
>>>>I there an easy way to know if the .sblive51 flag is needed ?
>>>>Does it is needed only for 3G SB card  (SBxxx version or those marked
>>>>as 5.1) ?
>>>
>>>
>>>
>>>I think it's need for any SBLive! (not Audigy) that has an analog
>>>center/LFE output.
>>>
>>>Maybe you could extract this information from the kX driver.
>>>
>>
>>on opencreative driver they use :
>>
>>* 5.1: Enable the additional AC97 Slots and unmute extra channels on
>>AC97 codec */
>>                if (codec->codec_read(codec, AC97_EXTENDED_ID) & 0x0080){
>>                        printk(KERN_INFO "emu10k1: SBLive! 5.1 card
>>detected\n");
>>                        sblive_writeptr(card, AC97SLOT, 0, AC97SLOT_CNTR
>>| AC97SLOT_LFE);
>>                        codec->codec_write(codec, AC97_SURROUND_MASTER,
>>0x0);
>>                }
>>
>>It correspond to AC97_EA_SDAC.
>>I don't know if it is a safe way...
>>
>>
>>Matthieu
>>
> 
> 
> It is not a safe way of detecting it.
> The approach I am going to take is mark each entry in the source code as
> tested and the email address of someone with the card.
> Then, over time we will have eventually tested all of them and also have
> a contact email address if it needs retesting.
ok, for CT4670 you could remove the flag and add my email adress.

Matthieu


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
