From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC] compress: add support for gapless playback
Date: Tue, 5 Feb 2013 23:54:19 -0800
Message-ID: <20130206075419.GF3143@intel.com>
References: <1360074085-562-1-git-send-email-vinod.koul@intel.com>
 <5111C39A.6020805@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BF232625EB
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2013 09:19:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5111C39A.6020805@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.jf.intel.com>
Cc: tiwai@suse.de, Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 05, 2013 at 08:44:42PM -0600, Pierre-Louis Bossart wrote:

 
> >  /**
> >+ * struct snd_compr_metadata: compressed stream metadata
> >+ * @encoder_delay: no of samples inserted by the encoder at the beginning
> >+ * of the track
> >+ * @encoder_padding: no of samples appended by the encoder at the end
> >+ * of the track
> >+ */
> >+struct snd_compr_metadata {
> >+	 __u32 encoder_delay;
> >+	 __u32 encoder_padding;
> >+};
> 
> You need to pad this structure with reserved bytes for future
> evolutions. Things like ReplayGain, etc, might be of interest for
> some implementations. Let's not be cheap here
Ok, makes sense, will update this and documentation.

 
> >+static int
> >+snd_compr_set_metadata(struct snd_compr_stream *stream, unsigned long arg)
> >+{
> >+	struct snd_compr_metadata *metadata;
> >+	int retval;
> >+
> >+	if (!stream->ops->set_metadata)
> >+		return -ENXIO;
> 
> Is this really a fatal error? Or do we want to mandate that gapless
> be supported by all implementations?
Fatal err? if DSP doesnt support metadata callback then we are reporting error
ENXIO to userpsace. No we shouldnt mandate, its upto DSP folks to see what they
should and can support.

--
~Vinod
