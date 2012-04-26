From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 2/5] ASoC: dpcm: Add debugFS support for
	DPCM
Date: Thu, 26 Apr 2012 17:57:29 +0100
Message-ID: <1335459449.4950.1.camel@odin>
References: <1335352373-5237-1-git-send-email-lrg@ti.com>
	<1335352373-5237-2-git-send-email-lrg@ti.com>
	<20120426164454.GM3207@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog102.obsmtp.com (na3sys009aog102.obsmtp.com
	[74.125.149.69])
	by alsa0.perex.cz (Postfix) with ESMTP id DEE5410BBA0
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2012 18:57:34 +0200 (CEST)
Received: by wibhq7 with SMTP id hq7so5242606wib.2
	for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2012 09:57:31 -0700 (PDT)
In-Reply-To: <20120426164454.GM3207@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2012-04-26 at 17:44 +0100, Mark Brown wrote:
> On Wed, Apr 25, 2012 at 12:12:50PM +0100, Liam Girdwood wrote:
> 
> I've queued this to apply this but a few nits I noticed:
> 
> > +#ifdef CONFIG_DEBUG_FS
> > +	dpcm->debugfs_state = debugfs_create_u32(be->dai_link->name, 0644,
> > +			fe->debugfs_dpcm_root, &dpcm->state);
> > +#endif
> 
> I have to say that this being writable seems rather scary...  any great
> need for that?

Ah, no - will fix this and the other two incrementally.

Regards

Liam
