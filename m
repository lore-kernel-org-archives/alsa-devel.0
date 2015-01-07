From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Add NULL checks for the
	stream pointer
Date: Wed, 7 Jan 2015 00:53:24 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901B7FB6E@SHSMSX101.ccr.corp.intel.com>
References: <1420556647-17270-1-git-send-email-yang.jie@intel.com>
 <20150106172223.GE2634@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E2852612D0
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 01:53:31 +0100 (CET)
In-Reply-To: <20150106172223.GE2634@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, January 07, 2015 1:22 AM
> To: Jie, Yang
> Cc: alsa-devel@alsa-project.org; Girdwood, Liam R
> Subject: Re: [PATCH] ASoC: Intel: Add NULL checks for the stream pointer
> 
> On Tue, Jan 06, 2015 at 11:04:07PM +0800, Jie Yang wrote:
> 
> > We should not send IPC stream commands to FW when the stream is NULL,
> > dereference the NULL pointer may also occur without precheck.
> > Here add NULL pointer checks for these stream APIs.
> 
> > @@ -1420,6 +1423,9 @@ int sst_hsw_stream_commit(struct sst_hsw *hsw,
> struct sst_hsw_stream *stream)
> >  	u32 header;
> >  	int ret;
> >
> > +	if (stream->commited)
> > +		return 0;
> > +
> >  	trace_ipc_request("stream alloc", stream->host_id);
> >
> >  	header = IPC_GLB_TYPE(IPC_GLB_ALLOCATE_STREAM);
> 
> This is a bit worrying, it means that we will silently ignore any attempts to pass
> in a NULL stream.  Sometimes that's an OK thing to do (like in deallocation
> paths) but this seems to more generally silently ignore errors which means
> we're less likely to spot other coding issues.
> Race conditions worry me especially - trying to use something before we've
> quite allocated it for example.
> 
> I'd be much happier if this warned in cases where it wasn't totally obvious that
> attempting to use a NULL pointer is sensible.
[Keyon] thanks for review, Mark. So you meant we should add some warning log here, right?


~Keyon
