From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Need expert's advice - Fast Track Ultra (8R)
 dropping samples
Date: Fri, 01 Oct 2010 13:00:05 +0200
Message-ID: <4CA5BF35.2030108@showlabor.de>
References: <4C9DC7A1.8050001@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203]) by alsa0.perex.cz (Postfix) with ESMTP id AA08D2440B
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 13:00:05 +0200 (CEST)
In-Reply-To: <4C9DC7A1.8050001@showlabor.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

I guess the right place to fix the issues mentioned in my original post 
is in snd_usb_init_substream() in urb.c:


         case USB_ID(0x0763, 0x2081): /* M-Audio Fast Track Ultra 8R */
             subs->ops.prepare_sync = prepare_playback_sync_urb;
             subs->ops.retire_sync = retire_playback_sync_urb;

I've tried combinations using the _hs and _emu versions of the 
retire.../prepare... functions. It either didn't change anything or made 
it worse. I guess we need  _ftu versions.

Could somebody at least tell me how to find out what's exactly going 
wrong with the sync. Can I find something useful monitoring the urbs in 
Windows?

Please, help me. We're so very close to full support of these devices, 
but I don't know how to proceed.

Thanks in advance,

Felix

Am 25.09.2010 11:57, schrieb Felix Homann:
> Hi,
>
> in that past months I've been trying get the Fast Track Ultra devices
> working properly in Alsa. We've had lots of progress, most of the code
> has moved to Alsa git and today I've even posted a patch for getting
> mixer support for these devices.
>
> Now, I need to get some expert's advice: The devices seem to drop
> samples or frames. Here's a report I've got today on the M-Audio forum:
>
> "I've got a subtle problem to report: I think audio playback is dropping
> sample frames. To hear the problem, open Audacity at 48 kHz and play
> a 10-kHz. sine wave. When I do that I hear a regular clicking sound, about
> four clicks a second. I've tried recording the output and if I'm seeing
> correctly,
> exactly one sample frame in every 13312 (13x1024) is being dropped on
> output.
> I don't see anything similar on input. When either jack or Pd has both
> the input and
> the output open, the delay from input to output gradually decreases
> until it forces
> occasional sync errors. (I haven't tried this with audacity though.)"
>
> (see
> http://forums.m-audio.com/showthread.php?714-Not-a-problem.-FastTrack-on-linux&p=98101#post98101)
>
> I could reproduce it on my machines, even at 44.1 kHz. The clicking
> sound is very subtle, it goes unnoticed when not listening to pure sines
> without attention to clicks.
>
> How can this be sorted out. Any ideas?
>
>    


> Kind regards,
>
> Felix
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>    
