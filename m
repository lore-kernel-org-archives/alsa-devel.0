From: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Subject: Re: Master Plan on rewinding
Date: Sun, 07 Sep 2014 21:38:07 +0300
Message-ID: <1410115087.2513.40.camel@tkkaskin-mobl3.ger.corp.intel.com.tanuk.dy.fi>
References: <540C76E0.9050808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 901B0260824
 for <alsa-devel@alsa-project.org>; Sun,  7 Sep 2014 20:38:11 +0200 (CEST)
In-Reply-To: <540C76E0.9050808@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 2014-09-07 at 21:16 +0600, Alexander E. Patrakov wrote:
> === On non-rewindability of the rate plugin ===
> 
> I intend to write a rewindable resampler eventually, but don't have time 
> now. I understand that it is an important task, but issues below (and 
> the dayjob which you can change by offering me a new one) have higher 
> priority for me. However, I want everyone to understand the following 
> point now:
> 
> "The resampler has to be written from scratch for the reasons explained 
> in http://permalink.gmane.org/gmane.linux.alsa.devel/122179 , and 
> similar arguments apply to all other kinds of sound processing code that 
> needs history."
> 
> For PulseAudio, it is also needed to figure out the desired interaction 
> between variable rate and rewindability. Should rewinding other than 
> "discard everything completely" be allowed at all on variable rate 
> streams when the rewind crosses the sample rate change point? I.e., 
> write 100 samples, change rate, write 50 samples, rewind 100 samples, 
> what should be the resulting rate? Should we special-case small changes 
> vs big ones?

This last paragraph isn't related to the rate plugin, right? So you're
talking about PulseAudio internals only? If so, perhaps the best
approach would be to make the current stream buffer contents
non-rewindable when a rate change occurs, at least until someone points
out a real use case where it is important to be able to rewind past rate
change points in the buffer. Without any example use cases, I don't feel
qualified to answer the question what should happen if a rewind crosses
a rate change point (or possibly several!).

Another question is that should we do something to previously buffered
stream data when the rate changes. If the audio rate changes completely,
e.g. from 44.1 kHz to 8 kHz, any previously buffered audio was probably
meant to be played at 44.1 kH, but with the current code it will be
played at 8 kHz. I don't know if there are any applications that (ab)use
the dynamic rate feature this way, though. Maybe we could just document
that the dynamic rate feature is only meant for small adjustments.

-- 
Tanu
