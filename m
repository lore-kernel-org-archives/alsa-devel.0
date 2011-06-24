From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: M-Audio FTU issues
Date: Fri, 24 Jun 2011 11:08:39 +0200
Message-ID: <4E045417.7050703@showlabor.de>
References: <BANLkTimOjiKwOqSveGvujMJ5uBL-JKsBeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 7100A103A4C
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jun 2011 11:08:43 +0200 (CEST)
In-Reply-To: <BANLkTimOjiKwOqSveGvujMJ5uBL-JKsBeA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

[I've received an Attachement Blocking Notification for the below 
message. Since I don't know if it was blocked for all recipients this is 
the same mail without the attachement.]


Hi again,

Am 24.06.2011 03:14, schrieb Daniel Mack:
>
> Hence my question is: How do you guys test? I renderened a sine tone
> in different samplerates and bit depths to .wav files and play them
> with aplay (no pulseaudio or anything in the chain). Could you try the
> same and report what happens?
>


OK, I've rendered a sine to a .wav (well, in audacity), played it via 
aplay on the FTU8R and could hear the clicks. I've been using plughw 
though, cause I don't remember right now how to convert bit-depths.

I even played sines directly from puredata and audacity without JACK and 
could still hear the clicks.

Please, make sure you have the routing "diagonal", i.e. "DIn i - Out j" 
is set to 0% if i !=j and 100% if i == j. I've attached a small bash 
script to accomplish this. After plugging the device in all playback 
volumes are initially at 100%. I could not notice the clicks then unless 
it turned the volume very very loud (I guess aplay plays back on all 
channels, which blurs the clicks).

If you still can't hear the clicks please try using a headphone? 
Sometimes the clicks are hardly noticable when there's minimal 
background noise. You might even have turn the volume higher than 
convenient for your ears...

I hope this helps hearing the clicks using the unmodified driver.

Kind regards,

Felix
