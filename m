From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: Re: [PATCH 2/5] ALSA: snd-usb: switch over to
	new	endpoint streaming logic
Date: Wed, 02 Nov 2011 23:01:54 +0100
Message-ID: <133664d7ea4.-1333182529382966585.4188469103496375013@zoho.com>
References: <1320063030-3502-1-git-send-email-zonque@gmail.com>
	<1320063030-3502-3-git-send-email-zonque@gmail.com>
	<4EB05D3A.60405@ladisch.de> <s5hfwi64ith.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id 27F6F10395C
	for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2011 23:01:59 +0100 (CET)
In-Reply-To: <s5hfwi64ith.wl%tiwai@suse.de>
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
Cc: gdiffey@gmail.com, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, linuxaudio@showlabor.de, blablack@gmail.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello,

I'm following the discussion about Daniel's patch because I'm at a similar point
with the 6fire driver - separating urb handling from alsa substream handling
and pcm callbacks. One comment catched my attention:

>> The trigger callback should execute very quickly; the initial URB 
>> submission should be handled in the prepare callback. 
> 
>Indeed this is a PITA since long time ago... In general, it's wrong 
>to do it in prepare callback. But we had to do just as a workaround. 
> 

It did because I always thought that would be the right place to start the
transfer. If it is not, what is the prepare callback supposed to do (at least
in the usb case)? Is it simply a check routine for the hw_params?

I also implemented copying data alsa<->urb in a tasklet. This tasklet
might actually also be a good choice for starting urb transfer if that should
be done in the trigger callback. If so, I'll change the 6fire driver
accordingly.

On the other side, the transfer would not necessarily have been started
when trigger finishes - one advantage of doing it in the prepare callback.
Does that matter for the alsa system?

Another question came into my mind: does alsa allow changing the hw_params
after prepare has been called?

Greets,
Torsten
