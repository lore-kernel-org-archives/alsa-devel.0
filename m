From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v3 4/6] core: add API header and driver
	header files
Date: Tue, 13 Dec 2011 12:01:30 +0530
Message-ID: <1323757890.1641.39.camel@vkoul-udesk3>
References: <1321951920-4363-1-git-send-email-vinod.koul@linux.intel.com>
	<1323070791-12620-5-git-send-email-vinod.koul@linux.intel.com>
	<20111213061134.GA7148@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id CB841103AC1
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 07:32:26 +0100 (CET)
In-Reply-To: <20111213061134.GA7148@opensource.wolfsonmicro.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-12-13 at 14:11 +0800, Mark Brown wrote:
> On Mon, Dec 05, 2011 at 01:09:49PM +0530, Vinod Koul wrote:
> 
> > +static inline void snd_compr_fragment_elapsed(struct snd_compr_stream *stream)
> > +{
> > +	wake_up(&stream->runtime->sleep);
> > +}
> 
> You need to include sched.h for this.
Hmmm, I have a different POV for these.
I would like driver to include the sched.h here and this not be in
header file.

While at it, am not really religious about this, so open to counter
argument :)

-- 
~Vinod
