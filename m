From: James Stafford <jstafford@ampltd.com>
Subject: Re: [PATCH] Envy24HT
Date: Wed, 04 Dec 2002 14:38:32 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m18JajL-003yUYC@mail.corpex.com>
References: <m18JZ72-003yUIC@mail.corpex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0212041402420.521-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

At 14:05 04/12/02 +0100, Jaroslav Kysela wrote:
 
>> I have added a build_controls function in the amp.c file which sets the
>> relavent ac97 register. Is this the correct way to do this?
>
>The controls should be built in the ac97_codec.c, but the initial settings 
>of AC97 registers might be done in the amp.c file.

All the controls are built in ac97_codec.c. I only write to one of the ac97
registers in the build_controls function from the snd_ice1712_card_info
structure because it was the only card specific function call after the
call to snd_ice1712_ac97_mixer. Would it be better to add a new function
pointer to the snd_ice1712_card_info structure for setting the initial
values of the chip specific ac97 registers (such as the rerouting of some
of the outputs) ?
I thought it was best not to write the ac97 register in ice1712.c since not
all Envy24HT cards use the VT1616.

>If you follow the ICH.conf file (and/or ICE1712.conf) file, then you can 
>use 'surround51' device as ac3dec uses: 'aplay -D plug:surround51' .
>The new name will be ICE1724.conf (I changed the driver ID for the new 
>chip). Unfortunately, at the time, we cannot distinguish more 
>hardware variations for given driver, but hopefully, it will change in the 
>future.

Ok, I understand you now. 

--
James Stafford


mailto:jstafford@ampltd.com

Advanced Micro Peripherals Ltd 
Unit 17
Sedgeway Business Park
Witchford
Cambridge
CB6 2HY

Tel: +44 1353 659 500 
Fax:+44 1353 659 600 



-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
