From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v2 3/3] topology: A API calls to directly
 build	topology data from templates
Date: Tue, 11 Aug 2015 13:36:22 +0100
Message-ID: <1439296582.2427.53.camel@loki>
References: <1439230429-6173-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1439230429-6173-4-git-send-email-liam.r.girdwood@linux.intel.com>
 <s5htws62r6d.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EC2E26051B
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 14:36:27 +0200 (CEST)
In-Reply-To: <s5htws62r6d.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Mengdong Lin <mengdong.lin@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2015-08-11 at 09:57 +0200, Takashi Iwai wrote:
> On Mon, 10 Aug 2015 20:13:49 +0200,
> Liam Girdwood wrote:

> 
> > +int snd_tplg_build(snd_tplg_t *tplg, const char *outfile)
> > +{
> > +	int err;
> > +
> > +	/* delete any old output files */
> > +	unlink(outfile);
> > +
> > +	tplg->out_fd =
> > +		open(outfile, O_RDWR | O_CREAT, S_IRWXU | S_IRWXG | S_IRWXO);
> > +	if (tplg->out_fd < 0) {
> > +		SNDERR("error: failed to open %s err %d\n",
> > +			outfile, -errno);
> > +		return -errno;
> > +	}
> > +
> > +	err = tplg_build_integ(tplg);
> > +	if (err < 0) {
> > +		SNDERR("error: failed to check topology integrity\n");
> > +		goto out;
> > +	}
> > +
> > +	err = tplg_write_data(tplg);
> > +	if (err < 0) {
> > +		SNDERR("error: failed to write data %d\n", err);
> > +		goto out;
> > +	}
> > +
> > +out:
> > +	close(tplg->out_fd);
> 
> It's a question whether we should unlink automatically at error or
> not.  If we leave the file as is, it should be documented.
> 

The unlink is not really needed so I'll remove it. The file permissions
should be 0600 too, so I'll fix that as well.

Liam
