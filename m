From: Lee Revell <rlrevell-2FmhHzymoG5BDgjK7y7TUQ@public.gmane.org>
Subject: Re: Again on sudden and
	occasional	Jack	crackling sound
Date: Wed, 10 Aug 2005 15:38:38 -0400
Message-ID: <1123702719.24369.24.camel@mindpipe>
References: <42F02BB2.3000201@virgilio.it> <42F62AE8.60604@virgilio.it>
	<87r7d4xmxm.fsf@localhost.localdomain> <42F7D849.3030000@virgilio.it>
	<87ll3byh42.fsf@localhost.localdomain>
	<1123557715.25617.32.camel@localhost.localdomain>
	<42F8A6AE.6010609@virgilio.it> <7q8xzb5ekw.fsf@io.com>
	<42F92B60.9020909@virgilio.it>
	<1123620561.25617.58.camel@localhost.localdomain>
	<1123639951.21956.5.camel@mindpipe>
Reply-To: A list for linux audio users <linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
In-Reply-To: <1123639951.21956.5.camel@mindpipe>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=unsubscribe>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-user>
List-Post: <mailto:linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=help>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=subscribe>
Sender: linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Errors-To: linux-audio-user-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: A list for linux audio users <linux-audio-user-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Cc: alsa-devel <alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-08-09 at 22:12 -0400, Lee Revell wrote:
> On Tue, 2005-08-09 at 16:49 -0400, Paul Davis wrote: 
> > as far as we can tell, this is an ALSA (kernel) driver issue. it does
> > not affect other backends, and does not affect (we think) every ALSA
> > supported piece of h/w. it would be nice for it to be either fixed or at
> > least tracked down conclusively.
> > 
> 
> OK, here's an idea.  Say there was an off-by-one error or some other bug
> in the ALSA middle layer that caused the reported value of the hardware
> pointer to be off by one.  So snd_pcm_avail_update would report 64
> frames available while there were actually 63.  If JACK gets scheduled
> within the space of one frame (quite possible especially with the RT
> kernel, it's a ~20us window at 48KHz) then we could overwrite the wrong
> part of the buffer - a frame or two ahead of the hardware pointer.
> AFAICT this would introduce a crackle, but no xruns would be reported.

Hmm, I think I might be on to something.  This sounds like the exact
same bug, but they can produce it without JACK:

http://www.winehq.org/hypermail/wine-patches/2005/08/0173.html

The WINE developer had the same idea:

      //* /*FIXME*/: snd_pcm_mmap_hw_ptr() should not be accessed by a user app. *//
      //*        It will NOT return what why want anyway. *//
      hw_ptr = _snd_pcm_mmap_hw_ptr(wwo->pcm);

  I thought, maybe it is not returning the correct information for 
  GetPosition, so that is why the crackling exists, since new samples are 
  off-position from what they should be in order to guarantee a smooth 
  sound

So in both cases we're operating in mmap mode and ALSA is returning a
slightly incorrect hardware pointer which leads to crackling.

Lee
