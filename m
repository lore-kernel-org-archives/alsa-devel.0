From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5 2/4] ALSA: compress: Add function to
 indicate the stream has gone bad
Date: Thu, 21 Apr 2016 09:26:57 +0100
Message-ID: <20160421082657.GD1581@localhost.localdomain>
References: <1461156003-24422-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1461156003-24422-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <5717A9ED.50706@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A3A82604DF
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 10:27:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5717A9ED.50706@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 20, 2016 at 11:10:21AM -0500, Pierre-Louis Bossart wrote:
> 
> >+ * snd_compr_stop_error: Report a fatal error on a stream
> >+ * @stream: pointer to stream
> >+ * @state: state to transition the stream to
> >+ *
> >+ * Stop the stream and set its state.
> >+ *
> >+ * Should be called with compressed device lock held.
> >+ */
> >+int snd_compr_stop_error(struct snd_compr_stream *stream,
> >+			 snd_pcm_state_t state)
> >+{
> >+	if (stream->runtime->state == state)
> >+		return 0;
> >+
> >+	stream->runtime->state = state;
> 
> Minor nit-pick: should there be a consistency check to make sure the new
> state makes sense - or maybe just a log to help debug? e.g. XRUN should only
> come if the state in run or draining stages, applying the new state
> unconditionally could lead to issues.

I think given the function can now report more than just a XRUN
it probably makes sense to set it unconditionally. As you might
be reporting some error that doesn't require the stream to be
running.

It probably would make sense to only call trigger with
TRIGGER_STOP if the stream is already running through. How about
I add a check for the state in the delayed work? And I can
certainly add a print to say the state was set, that probably
makes sense anyway as it is an error being reported.

> And question for my education since I see no lock/mutex: is the state always
> consistent or is there a risk of this state being changed while some other
> thread or interrupt handling modifies it was well?

As the comment says it is expected the lock should be held when
calling the function. I could put a lockdep assert in, if we want
to be cautious on this front?

Thanks,
Charles
