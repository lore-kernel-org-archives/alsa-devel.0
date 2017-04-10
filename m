From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RESEND PATCH] conf/cards: add VC4-HDMI card
Date: Mon, 10 Apr 2017 14:09:11 +0200
Message-ID: <20170410140911.2fb09a20@bbrezillon>
References: <1488451773-22010-1-git-send-email-boris.brezillon@free-electrons.com>
 <s5hinn4w6l8.wl-tiwai@suse.de> <87lgrd48ve.fsf@eliezer.anholt.net>
 <s5h60igaar8.wl-tiwai@suse.de> <87r314qgmj.fsf@eliezer.anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id C70D426686A
 for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2017 14:09:22 +0200 (CEST)
In-Reply-To: <87r314qgmj.fsf@eliezer.anholt.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Anholt <eric@anholt.net>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Eric, Takashi,

On Fri, 07 Apr 2017 10:20:20 -0700
Eric Anholt <eric@anholt.net> wrote:

> Takashi Iwai <tiwai@suse.de> writes:
> 
> > On Thu, 06 Apr 2017 21:46:29 +0200,
> > Eric Anholt wrote:  
> >> 
> >> Takashi Iwai <tiwai@suse.de> writes:
> >>   
> >> > On Thu, 02 Mar 2017 11:49:33 +0100,
> >> > Boris Brezillon wrote:  
> >> >> 
> >> >> Add a conf file for the VC4-HDMI sound card.
> >> >> 
> >> >> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> >> >> ---
> >> >> Hi,
> >> >> 
> >> >> Sorry for the noise, but I didn't send this patch to the alsa-lib
> >> >> maintainer on my first attempt.
> >> >> 
> >> >> This patch is adding a card config file for the audio sound card whose
> >> >> driver has been submitted here [1] (not accepted yet).
> >> >> 
> >> >> Since I am a total newbie to the alsa world, I'd like to get some
> >> >> feedback on this patch.
> >> >> 
> >> >> Also, the card only supports 2 to 8 channels, and I wonder if we should
> >> >> add a plug element to support mono streams, and where this element
> >> >> should be added (after or before the iec958 element).  
> >> >
> >> > Applied, thanks.  
> >> 
> >> Thanks!
> >> 
> >> Any recommendations on how to restructure this so that things like
> >> 'aplay' from the console also work by default?  
> >
> > Well, once after you have your card config in
> > /usr/share/alsa/cards/vc4-hdmi.conf, aplay should work as is.
> >
> > If not, check /proc/asounds output.  The entry looks like
> >  0 [ID            ]: DRIVER - SHORTNAME
> >                      LONGNAME
> >
> > and in your case, "DRIVER" must be "vc4-hdmi", as same as the config
> > file name.  
> 
> It doesn't work as is -- the default ends up not having iec958
> conversion, so nothing will play.  You can do aplay -D iec958, which
> works but only as long as you've got stereo input (it seems plug can't
> do mono-to-stereo on iec958 data)

Sorry for being so silent during the past weeks, but I've been busy
with other things and was on vacation last week.

As Eric explained, we're looking for advices on how to best expose
the sound card so that it can be easily used by end-users without
requiring advanced options (like -D iec958) or conf tweaking (like
declaring an extra plug element before the iec958 one to convert from
mono to stereo and then using -D iec958-mono).

Takashi, what do you suggest? Is it possible/acceptable to make iec958
the default for this card? What about implicit/automatic mono-to-stereo
conversion, is it achievable?

Thanks,

Boris
