From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Problems with nonblocking capture every 20ms
Date: Mon, 10 Mar 2008 21:19:39 +0000
Message-ID: <200803102119.39364.gineera@aspect135.co.uk>
References: <47D55396.3080705@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id D833A10385D
	for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2008 21:49:39 +0100 (CET)
In-Reply-To: <47D55396.3080705@web.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Johannes Dohmen <johannes.dohmen@web.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Monday 10 March 2008 15:28, Johannes Dohmen wrote:
> Hi there,
>
> With a sampling rate of 8000 I want to capture every 20ms a chunk (160
> frames) of data from the soundcard. That works ok, but every ~5 seconds
> I get a EGAIN from snd_pcm_readi().
> I understand that this is not an error but a notification that the sound
> card is not ready and should be asked again for data later on.
>
> Probably the easiest way to get rid of the EGAINs would be to use
> blocking IO, which I would prefer, but I have timing restrictions and
> snd_pcm_readi() has no sort of timeout (which I could see at least).
>
> Additional Information:
> The reason for me the read from the sound card every 20ms is, that I
> need to do so for my voip-app (rtp&sip) which needs to send 160 frames
> every 20ms. The calculation is:
> PacketsPerSecond=50
> SampleRate=8000
> FramesPerPacket=8000/50=160
> Wait=1000ms/50=20ms
>
> I know that EAGAINs might occur and I'm confident that I
> handle them ok on the RTP-Level (which is to notify the other side which
> then plays empty samples). Still I would guess, that I could
> receive much less EGAINs if I would setup the sound card better.
> If played around with the period time and size and buffer time and size,
> but honestly I did not really get the point of them and try&error has
> not helped me either.


Remember that you may have different clocks for different parts of your 
system, and if so they cannot lock exactly for ever.  Eg if the soundcard has 
it's own clock/crystal, it won't be exactly the same as the processor timing 
clock.  If the soundcard were running slightly slower, the rate it generates 
samples would be slightly less than the rate you are trying to read them out.  
Eventually you have emptied the buffer completely, and readi has to wait.

There has to be a synchronising mechanism of some sort. (Though I am no expert 
here.)  One way is to derive everything from the soundcard, so when 160 
frames are ready, another 20ms must have passed, and your  app processes it.  
Another is to add or remove samples occasionally to maintain sync.

If I have missed something, hopefully others will chip in.

Alan
