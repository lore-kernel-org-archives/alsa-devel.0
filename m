From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [PATCH] ASoC: Use codec mutex in dapm_set_pga()
Date: Thu, 01 Oct 2009 14:56:24 +0300
Message-ID: <1254398184.2472.45.camel@eenurkka-desktop>
References: <1254377856-5588-1-git-send-email-ext-eero.nurkkala@nokia.com>
	<20091001103714.GB14417@sirena.org.uk>
	<1254394869.2472.25.camel@eenurkka-desktop>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 9AECB10390A
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 13:57:42 +0200 (CEST)
In-Reply-To: <1254394869.2472.25.camel@eenurkka-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2009-10-01 at 13:01 +0200, Nurkkala Eero.An (EXT-Offcode/Oulu)
wrote:
> On Thu, 2009-10-01 at 12:37 +0200, ext Mark Brown wrote:
> > On Thu, Oct 01, 2009 at 09:17:36AM +0300, ext-eero.nurkkala@nokia.com wrote:
> > > From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> > 
> > > codec->mutex seems required if widget->* values
> > > are altered. Moreover, snd_soc_dapm_put_volsw()
> > > may alter widget->saved_value. dapm_set_pga()
> > > uses widget->saved_value in a for loop which now
> > > has a distant chance of getting out of control.
> > 
> > Hrm.  This doesn't look right.  dapm_set_pga() is only called from
> > within the DAPM power updates so we should've taken the codec mutex much
> > further up the stack otherwise all the DAPM list walking and updating
> > will have issues.  Was this just from code inspection or are you running
> > into actual issues?
> 
> No, codex mutex is not taken further up the stack.
> I ran lockdep for the case also. I also placed the mutexes
> so that they're always taken in the same function.
> 
> I still think the described scenario can happen. Or could
> you point where the mutex is taken earlier? If it was,
> I would've deadlocked every time....Maybe I'm missing
> some info.
> 
> BTW, what's the reasoning for codec mutex anyway?
> 
> (Yes, it was just code inspection).
> 
> - Eero

Actually, in this case: (kernel 2.6.28)

snd_soc_dapm_put_volsw() (mutex_lock(&widget->codec->mutex);) ->
dapm_mixer_update_power() ->
dapm_power_widgets() ->
dapm_set_pga()

and with this patch it would deadlock. (would try to take
the mutex twice).

But if it didn't come from snd_soc_dapm_put_volsw(),
but instead:
close_delayed_work() ->
snd_soc_dapm_stream_event() ->
dapm_power_widgets() ->
dapm_set_pga()
then the codec->mutex is not taken,
and the bug presented in the patch is out there, no?

Eg. if snd_soc_dapm_put_volsw() is called, it can alter
widget->saved_value meanwhile damp_set_pga() is being
using the same value in a for loop.

So yes, my patch makes things worse, but this use of
codec mutex doesn't appear very clear to me. (possibly
everybody else knows it far better =)

- Eero
