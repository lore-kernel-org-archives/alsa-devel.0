From: Kai Vehmanen <kvehmanen@eca.cx>
Subject: Re: snd_pcm_delay, hw buffers and driver api (v2)
Date: Fri, 14 Aug 2009 00:57:47 +0300 (EEST)
Message-ID: <alpine.DEB.1.10.0908140039270.3417@ecabase.localdomain>
References: <alpine.DEB.1.10.0908140023240.3417@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw01.mail.saunalahti.fi (gw01.mail.saunalahti.fi
	[195.197.172.115])
	by alsa0.perex.cz (Postfix) with ESMTP id 73BEC103878
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Aug 2009 23:57:26 +0200 (CEST)
In-Reply-To: <alpine.DEB.1.10.0908140023240.3417@ecabase.localdomain>
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

Hi,

[ continuing to restart the thread. Here's a reply to Mark's mail to the
   original misplaced thread at:
   http://kerneltrap.org/mailarchive/alsa-devel/2009/7/30/6272573 ]

On Thu, 13 Aug 2009, Mark Brown wrote:
> On Thu, Aug 13, 2009 at 11:46:52PM +0300, Kai Vehmanen wrote:
>> But how would a driver expose both bits of info to apps (in a standard
>> fashion): 1) the hw_ptr for shuffling bits out of the ringbuffer, and 2)
>> the delay to next played-out/captured sample. For application developers,
>> (2) is the piece of info we are mostly interested in (if I write a sample
>> now, how long it will be until it's played out).
>
> Both bits of information are very interesting to applications - some
> applications want to work on the data they're sending for as long as
> possible (things like pulse which do mixing are the obvious example of
> this).

For sure, that's true. I was meaning to say, that when using 
snd_pcm_delay(), (2) is what applications are mostly interested in. But 
yeah, snd_pcm_avail()/snd_pcm_avail_delay() are certainly important to 
applications as well. But I initialled ignored this part, as it would seem 
this part of the API is already in good shape (especially after the recent 
updates like snd_pcm_avail_delay()).

>> Any update/ideas on this topic? Personally I think adding a new driver
>> callback would make most sense, as that would allow to take full benefit
>> from hardware that allows to query sample-accurate position of playout
>> (i.e. not just support exposing a fixed latency). Of course that's
>> potentially a big change. In alsa-lib, snd_pcm_hwsync() could call this
>> driver callback, and a new variant of snd_pcm_delay() could present the
>> information to the applications.
>
> If we're adding a new API it should be possible to add one which
> provides the required information without disturbing the semantics of
> the existing APIs.

For sure. Changes to e.g. snd_pcm_delay() semantics (especially with 
current set of drivers) would cause no end of nasty bugs, agreed. Probably 
reusing snd_pcm_hwsync() is a bad idea as well. Maybe just add a new 
snd_pcm_hwdelay() or some such which calls the new driver callback (-> 
provides an atomic snapshot of snd_pcm_avail_delay + fill-status of ext-hw 
buffers).
