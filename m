From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: A FIX FOR alsa-lib emu10k1.h (IT FIXES ld10k1)
Date: Fri, 19 Jan 2007 09:58:17 +1100
Message-ID: <45AFFB89.5050901@superbug.co.uk>
References: <200701170012.07474.terminator356@users.sourceforge.net>
	<s5hzm8hzv9d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hzm8hzv9d.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: terminator356@users.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 17 Jan 2007 00:12:07 -0500,
> terminator356@users.sourceforge.net wrote:
>   
>> Hi, ld10k1 doesn't work, crashes. Lots of people saying it.
>> In the alsa-kernel/include emu10k1.h, 
>> 	union {
>> 		snd_kcontrol_tlv_rw_t *c;
>> 		unsigned int *p;
>> 	} tlv;
>>  was added to struct 'snd_emu10k1_fx8010_control_gpr'.
>> But alsa-lib/include/sound/emu10k1.h was not changed.
>> So I did this:
>>         ...
>> 	unsigned int min;		/* minimum range */
>> 	unsigned int max;		/* maximum range */
>>         unsigned int *p;    // <----- ADDED THIS  <----------------
>> 	unsigned int translation;	/* translation type (EMU10K1_GPR_TRANSLATION*) */
>> } emu10k1_fx8010_control_gpr_t;
>>  
>>  which is in alsa-lib/include/sound/emu10k1.h
>>
>> For me, it fixes ld10k1. *p acts as a placeholder because it is useless 
>>  (at this point) to ld10k1. 
>>
>> ----Can you tell me what those changes were for? What are *c and *p ? ---
>>     
>
> Well, this is an ABI breakage by introducing the TLV support.
> The tlv keeps the additional information such as dB range.
>
> James, do you have already a fix?
> I'm afraid that fixing this isn't so obvious and relatively
> complicated.
>
>
> Takashi
>   
I am busy at the moment, but I will look into this in a week or so.

James


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
