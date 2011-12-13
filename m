From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 4/6] core: add API header and driver
 header	files
Date: Tue, 13 Dec 2011 20:51:35 +0800
Message-ID: <20111213125134.GM7148@opensource.wolfsonmicro.com>
References: <3CA6C6D9F70D314CA34352990B57DA1507CCB50B02@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CE210103B48
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 13:51:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <3CA6C6D9F70D314CA34352990B57DA1507CCB50B02@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Vinod Koul <vinod.koul@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 13, 2011 at 06:19:49PM +0530, Nallasellan, Singaravelan wrote:
> > +struct snd_compr_runtime {
> > +	snd_pcm_state_t state;
> > +	struct snd_compr_ops *ops;
> > +	void *buffer;

> Can we define buffer as char *?

Clearly we *can* but why would we want to do that for a pointer to
unstructured data?

> > +	size_t buffer_size;
> > +	size_t fragment_size;

> Can we define buffer_size and fragment_size as unsigned items? 
> Can we have negative size here?

Again, what is the advantage in doing this?
