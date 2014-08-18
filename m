From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [v4 02/12] ASoC: Intel: mrfld: set private data
	for cpu-dai
Date: Mon, 18 Aug 2014 11:09:23 +0530
Message-ID: <22229.0593585514$1408341746@news.gmane.org>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
 <1407145563-1303-3-git-send-email-subhransu.s.prusty@intel.com>
 <20140813194531.GM17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id BFC2B26547A
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 08:01:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140813194531.GM17528@sirena.org.uk>
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

On Wed, Aug 13, 2014 at 08:45:31PM +0100, Mark Brown wrote:
> On Mon, Aug 04, 2014 at 03:15:53PM +0530, Subhransu S. Prusty wrote:
> 
> > We set the driver private data for media dai so that we can use in media
> > operations
> 
> This is another one where making the changelog clearer - as far as I can
> tell what this is actually doing is moving the existing private data
> from being per platform to being per DAI.  That actually seems OK and I
> would've applied this but it looks like it depends on patch 1.
> 
Will take care. 
> This lack of clarity is a frequent issue with both of these DSP
> serieses, it's really slowing down review since they're quite big and
> hard to read.
> 
> > +static int sst_media_dai_probe(struct snd_soc_dai *cpu_dai)
> > +{
> > +	struct sst_data *sst = dev_get_drvdata(cpu_dai->dev);
> > +
> > +	snd_soc_dai_set_drvdata(cpu_dai, sst);
> > +	return 0;
> > +}
> >  static struct snd_soc_dai_driver sst_platform_dai[] = {
> 
> Missing blank line here - this is a frequent issue with this code.



-- 
