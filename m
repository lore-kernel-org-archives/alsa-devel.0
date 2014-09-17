From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH v6 04/10] ASoC: Intel: mfld-pcm: add
 control for powering up/down dsp
Date: Wed, 17 Sep 2014 16:26:47 +0530
Message-ID: <32842.5576248721$1410952806@news.gmane.org>
References: <1410255693-6958-1-git-send-email-subhransu.s.prusty@intel.com>
 <1410255693-6958-5-git-send-email-subhransu.s.prusty@intel.com>
 <20140916190343.GC7960@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id F319926536F
 for <alsa-devel@alsa-project.org>; Wed, 17 Sep 2014 13:19:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140916190343.GC7960@sirena.org.uk>
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
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 16, 2014 at 12:03:43PM -0700, Mark Brown wrote:
> On Tue, Sep 09, 2014 at 03:11:27PM +0530, Subhransu S. Prusty wrote:
> 
> > @@ -129,6 +129,7 @@ struct sst_ops {
> >  	int (*stream_read_tstamp) (struct device *dev, struct pcm_stream_info *str_info);
> >  	int (*send_byte_stream)(struct device *dev, struct snd_sst_bytes_v2 *bytes);
> >  	int (*close) (struct device *dev, unsigned int str_id);
> > +	int (*power)(struct device *dev, bool state);
> 
> These seem to have a mix of )( and ) ( - it was a preexisting problem
> but still...

Will fix.

-- 
