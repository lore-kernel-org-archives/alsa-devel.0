From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [linux-audio-user] Again on sudden and
 occasional	Jack	crackling sound
Date: Tue, 09 Aug 2005 22:12:30 -0400
Message-ID: <1123639951.21956.5.camel@mindpipe>
References: <42F02BB2.3000201@virgilio.it> <42F62AE8.60604@virgilio.it>
	 <87r7d4xmxm.fsf@localhost.localdomain> <42F7D849.3030000@virgilio.it>
	 <87ll3byh42.fsf@localhost.localdomain>
	 <1123557715.25617.32.camel@localhost.localdomain>
	 <42F8A6AE.6010609@virgilio.it> <7q8xzb5ekw.fsf@io.com>
	 <42F92B60.9020909@virgilio.it>
	 <1123620561.25617.58.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1123620561.25617.58.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: paul@linuxaudiosystems.com, A list for linux audio users <linux-audio-user@music.columbia.edu>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-08-09 at 16:49 -0400, Paul Davis wrote:
> On Tue, 2005-08-09 at 22:17 +0000, Salvatore Di Pietro wrote:
> 
> > Moreover, using jack_bufsize, or resizing buffer within Ardour, causes 
> > complete muting of output sound (bit not clients death, as it was 
> > before), until I restart jack.
> > Notice that this "complete muting" only affects the output ports, i.e. I 
> > can continue recording with qarecord, or ardour, I just cannot hear (and 
> > monitor) anything anymore until I restart jack and its clients.
> 
> as far as we can tell, this is an ALSA (kernel) driver issue. it does
> not affect other backends, and does not affect (we think) every ALSA
> supported piece of h/w. it would be nice for it to be either fixed or at
> least tracked down conclusively.
> 

OK, here's an idea.  Say there was an off-by-one error or some other bug
in the ALSA middle layer that caused the reported value of the hardware
pointer to be off by one.  So snd_pcm_avail_update would report 64
frames available while there were actually 63.  If JACK gets scheduled
within the space of one frame (quite possible especially with the RT
kernel, it's a ~20us window at 48KHz) then we could overwrite the wrong
part of the buffer - a frame or two ahead of the hardware pointer.
AFAICT this would introduce a crackle, but no xruns would be reported.

Does this sound reasonable?

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
