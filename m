From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/3] ASoC: Add signal generator widget type
Date: Thu, 01 Dec 2011 15:55:14 +0000
Message-ID: <1322754914.4712.5.camel@odin>
References: <1322686625-16488-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1322753220.4712.2.camel@odin> <20111201153050.GA28076@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog115.obsmtp.com (na3sys009aog115.obsmtp.com
	[74.125.149.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EA6624133
	for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2011 16:55:21 +0100 (CET)
Received: by mail-ee0-f44.google.com with SMTP id r51so2035559eea.17
	for <alsa-devel@alsa-project.org>; Thu, 01 Dec 2011 07:55:19 -0800 (PST)
In-Reply-To: <20111201153050.GA28076@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-12-01 at 15:30 +0000, Mark Brown wrote:
> On Thu, Dec 01, 2011 at 03:27:00PM +0000, Liam Girdwood wrote:
> > On Wed, 2011-11-30 at 20:57 +0000, Mark Brown wrote:
> > > A signal generator behaves as an input would but is not considered for
> > > any of the special behaviour associated with external input pins. This
> > > is especially useful when automatically working out not connected widgets.
> 
> > Would this not be an output type ?
> 
> It's a signal source - in terms of the DAPM graph and figuring out a
> route from an input to an output it's an input.

Ah, OK - I'm thinking here of an internal signal generator (i.e. coming
from within platform/codec). e.g. we could add a simple sine wave
generator to OMAP4 ABE for test/debug purposes.

Regards

Liam
