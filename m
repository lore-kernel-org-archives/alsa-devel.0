From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] Support for Audigy2 Value SB0400
Date: Mon, 22 Nov 2004 18:33:47 +0000
Message-ID: <41A2310B.3030104@superbug.co.uk>
References: <419FF760.8050200@superbug.co.uk>	<s5hd5y6dnds.wl@alsa2.suse.de>	<1101145818.2873.6.camel@krustophenia.net> <s5hmzx9vk6l.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hmzx9vk6l.wl@alsa2.suse.de>
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
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Mon, 22 Nov 2004 12:50:18 -0500,
> Lee Revell wrote:
> 
>>On Mon, 2004-11-22 at 14:27 +0100, Takashi Iwai wrote:
>>
>>>The patch looks fine.  Could you provide the nice patch description
>>>and the signed-off-by lines?
>>
>>Also, I noticed the patch contains some /proc changes.  Care to comment
>>a little on these?  I was also planning to improve the /proc support,
>>but don't want to duplicate any work.
> 
> 
> Yep, at best, the patch should be splitting three parts with summary,
> descrption and signed-off-by lines for each:
> 
> - fix for snd_emu10k1_compose_audigy_*() macros
> - addition of Audigy2 Value support
> - addition to proc for register dump
> 
> 
> James, could you do this?
> 
> thanks,
> 
> Takashi
> 
> 

I could, but it will have to wait till next weekend.
The register dump should only happen if the driver is built with 
CONFIG_SND_DEBUG switched on.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
