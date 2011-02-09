From: Arthur Marsh <arthur.marsh@internode.on.net>
Subject: Re: MIDI playback not keeping steady time with recent
 kernels
Date: Wed, 09 Feb 2011 11:21:26 +1030
Message-ID: <4D51E50E.8000703@internode.on.net>
References: <559v18-575.ln1@ppp121-45-136-118.lns11.adl6.internode.on.net>	<bma128-mok.ln1@ppp121-45-136-118.lns11.adl6.internode.on.net>	<elo128-8u4.ln1@ppp121-45-136-118.lns11.adl6.internode.on.net>
	<11c228-725.ln1@ppp121-45-136-118.lns11.adl6.internode.on.net>
	<4D512EA9.2020909@ladisch.de> <4D515EFD.3040909@internode.on.net>
	<4D5163D8.8010708@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipmail05.adl6.internode.on.net (ipmail05.adl6.internode.on.net
	[150.101.137.143])
	by alsa0.perex.cz (Postfix) with ESMTP id E4112244B8
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 01:51:48 +0100 (CET)
In-Reply-To: <4D5163D8.8010708@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



Clemens Ladisch wrote, on 09/02/11 02:10:
> Arthur Marsh wrote:
>> OK, I applied this patch.
>>
>> When the MIDI file was playing:
>> I still experienced some slow-down and speed-up under heavy load.
>
> Is "some" less than previously?

The amount of slow-down appears to be less than previously.

>
> It shouldn't be possible to get a speed-up; this looks as if your
> computer's clock is not stable.  Are you using an NTP daemon?

To clarify, the speed-up is back to original tempo, and yes I'm using an 
NTP daemon. There has been an issue of the pc not keeping accurate time 
under GNU/Linux even with ntpd running and using an NTP server a few 
hops away.

>
> What kind of heave load is this?  Does the same happen if you execute
> "yes | tail" in a shell?

The load when I experienced this problem was about 4 or 5, and mainly 
seemed to be tied to activities that caused swapping (e.g. running 
aptitude -u when other applications were using all available memory and 
some swap).

After quitting some applications so that there was no swapping going on 
(kswapd0 showing 0.0 cpu), the MIDI file played fine, even with 
"yes|tail" running.

Adding aptitude -u to the mix, which resulted in kswapd0 running at 4 to 
10 percent cpu, caused a slow-down.


>
>
> Regards,
> Clemens
>

Thanks again,

Arthur.
