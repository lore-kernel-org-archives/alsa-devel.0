From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: Add signal generator widget type
Date: Thu, 1 Dec 2011 15:30:50 +0000
Message-ID: <20111201153050.GA28076@sirena.org.uk>
References: <1322686625-16488-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1322753220.4712.2.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id AC5661039C0
	for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2011 16:30:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1322753220.4712.2.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 01, 2011 at 03:27:00PM +0000, Liam Girdwood wrote:
> On Wed, 2011-11-30 at 20:57 +0000, Mark Brown wrote:
> > A signal generator behaves as an input would but is not considered for
> > any of the special behaviour associated with external input pins. This
> > is especially useful when automatically working out not connected widgets.

> Would this not be an output type ?

It's a signal source - in terms of the DAPM graph and figuring out a
route from an input to an output it's an input.
