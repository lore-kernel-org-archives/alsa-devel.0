From: Lukas Degener <AFBLukas-Mmb7MZpHnFY@public.gmane.org>
Subject: [Fwd: Re: [linux-audio-user] DSP2000 C-PORT and
	MIDI input]
Date: Mon, 26 Apr 2004 11:40:39 +0200
Sender: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Message-ID: <408CD917.3070700@gmx.de>
Reply-To: "The Linux Audio Developers' Mailing List"
	<linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1v5P9MsFVvkkBB/WhxxnpHQ@public.gmane.org>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1aFUAG64dwko@public.gmane.org>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfocZ5a6xMsm1+iqrErVy8Mf2+df2TVCvIA@public.gmane.org>
Errors-To: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: LAD Mail <linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>, alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi everybody and sorry for posting this to both, lad and alsa-dev,
i was not sure which one fits better.

Concerning the issue with non-functional midi in on the DSP2000 c-port:
Someone on lau(Clemens?) said the problem is a lack of information an 
how to enable some interrupts.
Matthew Skinner contacted me a couple of days ago (actualy replying to a 
thread on lau, i think), offereing to provide the missing info + 
additional help.

Anyone interested and able to do the required changes should contact 
him: matt-h1laINijYsWj7JPsHwAtPg@public.gmane.org

the original "dialog" is attached below. I'm sorry, it is a little 
cluttered by my mail client :-) hope you can read it anyway.

Kind Regards,
Lukas


----- Original Message ----- 
From: "Lukas Degener" <AFBLukas-Mmb7MZpHnFY@public.gmane.org>
To: "Matthew Skinner, Sound and Music Tech Support" <matt-h1laINijYsWj7JPsHwAtPg@public.gmane.org>
Sent: Saturday, April 24, 2004 5:50 AM
Subject: Re: [linux-audio-user] DSP2000 C-PORT and MIDI input


> Matthew Skinner, Sound and Music Tech Support wrote:
>
> > If you can program in c++ and want to get the midi io working on the
> > cport then let me know what you need.
>
> I doubt my programming skills are sufficient to perform ad-hoc
> modifications on the alsa driver layer, at least not without a
> exorbitant amount of spare time, which i currently heavily lack :-)
>
> As for what is needed/missing: As Clemens said on lau:
>
> > Currently, this bug cannot be fixed because nobody knows how to enable
> > MIDI interrupts on this card.
>
> I'm not familiar with driver programming, so i can only vaguely guess,
> that there is a lack of specifications on certain parts of the c-port
> hardware.
> If you can provide this information, i imagine the alsa developers would
> much apreciate it. It would propably make sense to post your offer on
> one of their mailing lists.
>
> Kind regards,
> Lukas
>
>
I dont know the best mailinglist to post to or I probably would do so. I can
provide the missing information and some more help.

If you want to find someone with the time, knowledge and passion to write
the extra code for linux then get them to contact myself.

Regards,

Matthew Skinner
Sound and Music Technical Support
