From: Anders Torger <torger@ludd.luth.se>
Subject: Re: Repeatable exact I/O-delay
Date: Sun, 28 Jul 2002 16:39:50 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020728143945.D582D902@mail.it4u.net>
References: <200207281353.g6SDrm407073@mother.ludd.luth.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.it4u.net (mail.it4u.net [81.8.150.196])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA29739
	for <alsa-devel@alsa-project.org>; Sun, 28 Jul 2002 16:40:17 +0200
In-Reply-To: <200207281353.g6SDrm407073@mother.ludd.luth.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sunday 28 July 2002 15.54, you wrote:
> >The way you'd do this is to link the capture and playback streams of
> >the device you use with snd_pcm_link(). They will start together and
>
> we still haven't established the timing for this. its possible that
> its not fast enough for the two streams to be started within
> <<1sample, particularly if and when 192kHz h/w appears. it might even
> be problematic with 96kHz operation. i would be suprised if this was
> true, but it needs to be measured and checked.

I've looked through some driver code, and if I understand it correctly, 
it seems like some drivers, for example the ens1370, check in the 
trigger function the substream is linked with other substreams on the 
card, and if so, it makes sure to start/stop them at the same time, by 
writing all the relevant bits to the control register at once, like 
this:

		snd_pcm_substream_t *s = substream;
		do {
			if (s == ensoniq->playback1_substream) {
				what |= ES_DAC1_EN;
				snd_pcm_trigger_done(s, substream);
			} else if (s == ensoniq->playback2_substream) {
				what |= ES_DAC2_EN;
				snd_pcm_trigger_done(s, substream);
			} else if (s == ensoniq->capture_substream) {
				what |= ES_ADC_EN;
				snd_pcm_trigger_done(s, substream);
			}
			s = s->link_next;
		} while (s != substream);
		spin_lock(&ensoniq->reg_lock);
		if (cmd == SNDRV_PCM_TRIGGER_START)
			ensoniq->ctrl |= what;
		else
			ensoniq->ctrl &= ~what;
		outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
		spin_unlock(&ensoniq->reg_lock);

So my particular problem should be solved on this card at least, am I 
right? However, if the problem includes access to several different 
cards, there could be a problem of course.

By the way, I tried to search for the same code in rme9652.c, and found 
something similar, but it does not seem to activate both capture and 
playback with a single write to the control register. I'm not sure how 
the hardware works (nor the driver) though so I may be wrong. I would 
very much like to know if linked playback/capture start will be 
synchronised, since I will use Hammerfall cards in my particular 
application.

/Anders Torger


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
