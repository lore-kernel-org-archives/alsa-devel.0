From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: PATCH - ESI Juli driver
Date: Mon, 17 Mar 2008 15:08:48 +0100
Message-ID: <47DE7B70.2040407@insite.cz>
References: <47DD1934.3000003@insite.cz>	<s5hod9du6gb.wl%tiwai@suse.de>	<47DE328D.1080009@insite.cz>	<s5htzj5r9d6.wl%tiwai@suse.de>	<47DE3BD2.5090007@insite.cz>
	<s5hwso1pkms.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id C9EDB103897
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 15:08:58 +0100 (CET)
In-Reply-To: <s5hwso1pkms.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Rainer Zimmermann <mail@lightshed.de>
List-Id: alsa-devel@alsa-project.org



Takashi Iwai wrote:
> At Mon, 17 Mar 2008 10:37:22 +0100,
> Pavel Hofman wrote:

>>
>> What would you recommend?
> 
> IMO, rate_code can be avoided.  Instead of exposing the encoded value,
> better to use the raw rate value as parameters.

No problem. I just wanted to avoid the repeated conversion from the 
numerical rate to the card specific representation which is input 
information for all the rate-related code. ice1724 cards utilize 
MT_RATE, juli makes use of GPIO.

If you are OK with the repeated conversion, I will remove this. I tried 
to keep the methods inline if possible.

> And, the texts inf rates_info can be generated dynamically.

For obvious reasons I tried changing ice1724 as little as possible. That 
is why I kept the original code, only rearranged it.

I can change the way texts in rates_info are generated. Still there will 
have to be some callback as juli has a different list of rates.

> 
> So, what we need primarily are callbacks to get and set the current
> rate setting.  Suppose rate=0 as SPDIF-in, we can pass the raw rate
> value.  Then snd_vt1724_pro_internal_clock_get() would just a function
> to get the current rate and compares it with the given rate_info[]
> value, returns the index.

I am afraid I do not understand what to change in 
snd_vt1724_pro_internal_clock_get(). It seems fairly logical, I made 
only minor changes - is_spdif_master used in other parts of the code, 
get_rate_index with a simple meaning.

> 
> How to set stream-specific hw_params is another question.  But surely
> we can cut off a bit more.

We probably can, by rewriting portions of the original well-tested 
ice1724 code. I really wanted to avoid that and changed by callbacks 
only the card-specific portions.

OK, I will remove the rate_code conversions, the new overhead will be 
low and one abstraction will be removed.

For the rest, please state you objectives. Either cutting a few of the 
callbacks by non-trivial rewrite of the original ice1724 code, or 
keeping the remaining callbacks and the well-tested code.

Thanks a lot,

Pavel.




> 
> 
> thanks,
> 
> Takashi

-- 
-----------------

inSITE, s.r.o.

Rubesova 29, 326 00 Plzen
Tel., fax: +420 - 37 - 74 493 58
GSM: +420 - 603 - 163 973
Email: pavel.hofman@insite.cz

www.educity.cz, www.insite.cz
www.meetings.cz, www.hrzive.cz
www.comben.cz, www.hr-online.cz
-------------------------------
Navstivte www.educity.cz, server
s nejvetsi nabidkou profesniho
vzdelavani na ceskem internetu.
