From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: proposal: snd_pcm_start_at()
Date: Thu, 02 Oct 2014 12:41:19 -0500
Message-ID: <542D8E3F.4080400@linux.intel.com>
References: <1412260460.3891605.174362449.667FB9BE@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 004EE2604BC
 for <alsa-devel@alsa-project.org>; Thu,  2 Oct 2014 19:41:26 +0200 (CEST)
In-Reply-To: <1412260460.3891605.174362449.667FB9BE@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Cussins <timcussins@eml.cc>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/2/14, 9:34 AM, Tim Cussins wrote:
> Hi all,
>
> I'm Tim: I work at Linn Products Ltd - we make Network Music Players,
> amongst other things.
>
> As you might imagine, synchronised-start is important when multiple
> devices on the network are rendering the same audio. We'd be interested
> in contributing a small expansion of the alsa-lib API to support
> synchronised start.
>
> Assuming we can synchronise the audio clocks (I'm aware this is not
> trivial - It's not the topic of this post), we'd propose something like:
>
>      int snd_pcm_start_at(snd_pcm_t* pcm, snd_htimestamp_t* tstamp);
>
> and playback would begin as close to tstamp as possible. If tstamp is in
> the past, it would should return an error.
>
> Recent work by Takashi Iwai enables client code to set the clock type of
> timestamps using snd_pcm_sw_params_set_tstamp_type(). This context could
> quite naturally extend to tstamp argument of snd_pcm_start_at().
>
> Before I get stuck into working up the details under the hood, it'd be
> good to get some feedback/objections regarding this approach.

It's probably better idea to start PCM playback with a bunch of zeroes 
and then rely on existing timestamping to insert samples at the right 
location in the ring buffer - which you have to do anyway to compensate 
for drifts between your network clock and audio clock. This is a more 
predictable solution that abstracts away all the time needed to arm DMA, 
FIFOs, etc. The only hardware-dependent variable that would remain is 
the precision/granularity of the timestamping.
-Pierre
