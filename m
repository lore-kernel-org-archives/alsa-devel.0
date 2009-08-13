From: Kai Vehmanen <kvehmanen@eca.cx>
Subject: snd_pcm_delay, hw buffers and driver api (v2)
Date: Fri, 14 Aug 2009 00:35:15 +0300 (EEST)
Message-ID: <alpine.DEB.1.10.0908140023240.3417@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw03.mail.saunalahti.fi (gw03.mail.saunalahti.fi
	[195.197.172.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D95DC24631
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Aug 2009 23:34:53 +0200 (CEST)
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
Cc: Ujfalusi Peter <peter.ujfalusi@nokia.com>, ext-eero.nurkkala@nokia.com
List-Id: alsa-devel@alsa-project.org

Hi,

as I got at least one reply, reposting this in a new thread to catch more 
people. Originally sent to alsa-devel thread:
"[PATCH 11/20] OMAP: McBSP: Add link DMA mode selection)"
http://kerneltrap.org/mailarchive/alsa-devel/2009/7/30/6272573

---

So not strictly related to the patch that started the original thread, but 
this touches on, and is a good example of, one question I've been 
wondering for some time now as an app developer. Could Takashi, Jaroslav, 
Mark, or others comment on this as well, perhaps? Dropping linux-omap as 
this is a generic ALSA question.

On Wed, 12 Aug 2009, Jarkko Nikula wrote:
[i.e. pcm_pointer == hw_ptr]
> The threshold based transfer will cause that omap_pcm_pointer will
> loose a bit its accuracy. Probably irrelevant but still better to play
> safe at least over one kernel release before making it default.
[...]
> element:
> 614
> 669
> 691
[...]
> threshold:
> 512
> 512
> 1024
> 1024

In both cases, this value (hw_ptr) shows the status of sending data to an 
separate entity, and one that has its own buffer (multiple ms) before the 
actual DAC/ADC.

So when application developer uses snd_pcm_delay(), the result is not 
quite what the ALSA API says:

alsa-lib.git/src/pcm/pcm.c:
--cut--
   * For playback the delay is defined as the time that a frame that is written
   * to the PCM stream shortly after this call will take to be actually
   * audible. It is as such the overall latency from the write call to the final
   * DAC.
[...]
int snd_pcm_delay(snd_pcm_t *pcm, snd_pcm_sframes_t *delayp)
--cut--

Of course, there are many other cases where the same happens, as the 
latency of the HW (or where it is connected) is not known. But we also 
have many cases where we _do_ know more about the latency, and we are just 
missing the means to expose this info. I think this applies to this OMAP 
patch as well. E.g. the HW can tell fairly accurately the current status 
(i.e. which sample is played-out/captured _now_). Now that brings us to my 
question -- how to expose this info in an ALSA driver.

Elsewhere in alsa-lib docs, there is more accurate description of 
current implementation and behaviour of snd_pcm_delay():
alsa-lib.git/src/pcm/pcm.c:
--cut--
The function #snd_pcm_delay() returns the delay in samples.
For playback, it means count of samples in the ring buffer before
the next sample will be sent to DAC.
--cut--

So e.g. the OMAP patch that this thread started from, complies with this 
definition, and element/threshold modes just differ in accuracy (although 
threshold implementation should warn the application with the 
SNDRV_PCM_INFO_BATCH flag).

But how would a driver expose both bits of info to apps (in a standard 
fashion): 1) the hw_ptr for shuffling bits out of the ringbuffer, and 2) 
the delay to next played-out/captured sample. For application developers, 
(2) is the piece of info we are mostly interested in (if I write a sample 
now, how long it will be until it's played out).

One obvious solution (that has been used already in other ALSA drivers) is 
to virtualize the hw_ptr, but this way you lose the accurate info about 
ringbuffer status. Ideally both pieces of info could be exposed. But as I 
see it, drivers currently can only implement "pointer" to relay this info.

Jaroslav proposed some ideas earlier this year, but then the discussion 
faded:
"Re: Driver code with mpc5200 pointer problem.", 2009-04-28
http://article.gmane.org/gmane.linux.alsa.devel/62170

Takashi made basicly the same point I've tried to make above
"Re: Driver code with mpc5200 pointer problem.", 2009-04-28 
http://article.gmane.org/gmane.linux.alsa.devel/62172

Mark also commented to the same thread:
http://article.gmane.org/gmane.linux.alsa.devel/62176, 2009-04-28

Any update/ideas on this topic? Personally I think adding a new driver 
callback would make most sense, as that would allow to take full benefit 
from hardware that allows to query sample-accurate position of playout 
(i.e. not just support exposing a fixed latency). Of course that's 
potentially a big change. In alsa-lib, snd_pcm_hwsync() could call this 
driver callback, and a new variant of snd_pcm_delay() could present the 
information to the applications.
