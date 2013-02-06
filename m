From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC] compress: add support for gapless playback
Date: Wed, 6 Feb 2013 05:56:49 -0800
Message-ID: <20130206135649.GG3143@intel.com>
References: <1360074085-562-1-git-send-email-vinod.koul@intel.com>
 <5111C39A.6020805@linux.intel.com>
 <20130206075419.GF3143@intel.com>
 <20130206133253.GM4720@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id A7FC0264F8D
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2013 15:21:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130206133253.GM4720@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.jf.intel.com>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 06, 2013 at 01:32:53PM +0000, Mark Brown wrote:
> On Tue, Feb 05, 2013 at 11:54:19PM -0800, Vinod Koul wrote:
> > On Tue, Feb 05, 2013 at 08:44:42PM -0600, Pierre-Louis Bossart wrote:
> 
> > > >+snd_compr_set_metadata(struct snd_compr_stream *stream, unsigned long arg)
> > > >+{
> > > >+	struct snd_compr_metadata *metadata;
> > > >+	int retval;
> > > >+
> > > >+	if (!stream->ops->set_metadata)
> > > >+		return -ENXIO;
> 
> > > Is this really a fatal error? Or do we want to mandate that gapless
> > > be supported by all implementations?
> 
> > Fatal err? if DSP doesnt support metadata callback then we are reporting error
> > ENXIO to userpsace. No we shouldnt mandate, its upto DSP folks to see what they
> > should and can support.
> 
> Well, up to userspace to see how it handles the error anyway.  For
> example an application may want to fall back to PCM playback with
> gapless done on the CPU if the driver doesn't do it.  But then given
> that there's more than one piece of metadata in the struct perhaps we
> need some way for the application to figure out what's supported?
This return would mean that API is not supported. If there is some other error
wrt metadata set then driver needs to send appropriate error which can help
userland figure out what caused this error

--
~Vinod
