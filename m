From: Jonathan Andrews <jon@jonshouse.co.uk>
Subject: Re: Trying to understand alsa
Date: Thu, 12 Jan 2012 23:45:40 +0000
Message-ID: <1326411940.23310.47.camel@jonspc>
Reply-To: jon@jonshouse.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.jonshouse.co.uk (unknown [91.84.151.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E27024402
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 00:42:03 +0100 (CET)
Received: from [10.10.10.6] (jonspc [10.10.10.6])
	by mail.jonshouse.co.uk (8.14.1/8.13.8) with ESMTP id q0CNjeSE019613
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 23:45:46 GMT
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
List-Id: alsa-devel@alsa-project.org

On Thu, 2012-01-12 at 16:12 -0600, Andrew Eikum wrote:
> On Thu, Jan 12, 2012 at 09:44:11PM +0000, Jonathan Andrews wrote:
> > I have an application that works using 512 sample packets of 22050Hz 16
> > bit mono audio.  The 'receiver' takes many audio streams from a network
> > via UDP, at the moment it pipes them into pulse.
> > 
> > Can alsa buffer audio. At the moment every time I and set an audio
> > buffer size I get a negative response from
> > snd_pcm_hw_params_set_buffer_size .  I'm somewhat confused about the
> > units alsa uses ...
> > 
> 
> You don't want to over-specify your requirements. You require a buffer
> size of "at least" 3 * 512 frames. So use set_buffer_size_min().

I cant find any reference to "set_buffer_size_min" in the ALSA API
documentation I have or the link you provided ?
snd_pcm_hw_params_set_buffer_time_near() is the closest and that seems
to take an argument in useconds.  
?
http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html


> Otherwise ALSA will try to set exactly that buffer size, which can
> fail.
> 
> Check the function signatures for units. Notice that
> set_buffer_size*() all take snd_pcm_uframes_t, that is, the number of
> frames you want to store. In ALSA terms, a "frame" is a set of a
> single sample for every channel. Since you have mono audio, a frame
> and a sample are actually the same unit (for 16 bit stereo audio,
> 1 frame = 2 samples = 32 bits).
> 
> > What I want to do is tell ALSA to hold a buffer of 3 of my packets (3 x
> > 1024Bytes, thats 512 x 16 bit samples) while I feed extra packets (1K
> > Byte, 512 samples per buffer) in for playback.  The packets are arriving
> > at roughly the correct rate, I just need a buffer to  iron out any
> > jitter in network transmit, do I have to do this myself ?
> > 
> > Can somebody help by telling me which numbers I push into which places
> > to make it work ?
> > 
> > At the moment I get i keep getting a broken pipe, if I underrun how can
> > I make it just wait for me ?
> > 
> 
> If a packet arrives very late (and one will, eventually), you will
> underrun.  That's unavoidable. You can check for SND_PCM_STATE_XRUN
> from snd_pcm_state().  It's undocumented, but you need to call
> snd_pcm_avail_update() first to get an accurate reading from
> snd_pcm_state(). When an underrun occurs, recover with
> snd_pcm_recover() and then start writing data again.
Ok, thanks.


> If a packet arrives early, you'll need to check that the ALSA buffer
> isn't full (see snd_pcm_avail_update()), and store it within your
> application to write later if it is full.
> 
> There's some mostly-accurate information here:
> http://0pointer.de/blog/projects/guide-to-sound-apis.html
> As with all ALSA documentation, it is confusing and often incorrect,
> but it's probably the most helpful document I've found.

Many thanks for the help,
Jon
