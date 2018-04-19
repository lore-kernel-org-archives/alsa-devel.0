From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/5] compress: remove dead code
 _is_codec_supported()
Date: Thu, 19 Apr 2018 13:38:33 +0530
Message-ID: <20180419080832.GH6014@localhost>
References: <1524119780-21206-1-git-send-email-vinod.koul@intel.com>
 <6b870058-e263-775f-f70b-55f159537666@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 55744266E30
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 10:03:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <6b870058-e263-775f-f70b-55f159537666@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 19, 2018 at 12:19:28AM -0700, Pierre-Louis Bossart wrote:
> On 4/18/18 11:36 PM, Vinod Koul wrote:
> >  static bool _is_codec_type_supported(int fd, struct snd_codec *codec)
> >  {
> >  	struct snd_compr_caps caps;
> >@@ -271,16 +228,6 @@ struct compress *compress_open(unsigned int card, unsigned int device,
> >  		config->fragments = caps.max_fragments;
> >  	}
> >-#if 0
> >-	/* FIXME need to turn this On when DSP supports
> >-	 * and treat in no support case
> >-	 */
> >-	if (_is_codec_supported(compress, config, &caps) == false) {
> >-		oops(compress, errno, "codec not supported\n");
> >-		goto codec_fail;
> >-	}
> >-#endif
> 
> Why was this commented out in the first place?

It depends on capabilities being reported properly which wasn't the case so we
had to turn it off...

> This seems like a valid check to me. If the application is asking for a
> codec that isn't supported by hardware, should it be allowed to proceed?

It has been dead for quite some time, I don't know if ppl are reporting
properly. Turning it on might break which is something I would like to
avoid

-- 
~Vinod
