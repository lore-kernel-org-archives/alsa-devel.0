From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] Null suspend/resume functions
Date: Tue, 17 Nov 2009 12:41:25 +0000
Message-ID: <20091117124125.GD823@rakim.wolfsonmicro.main>
References: <ud43sjtaf.wl%morimoto.kuninori@renesas.com>
	<20091109105858.GB1245@sirena.org.uk>
	<20091109133136.GC1245@sirena.org.uk>
	<20091116153000.GB29479@sirena.org.uk>
	<20091117115236.GB1376@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AADD71038D9
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2009 13:41:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091117115236.GB1376@ucw.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, linux-kernel@vger.kernel.org, Magnus Damm <damm@opensource.se>, alsa-devel@alsa-project.org, linux-pm@lists.linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 17, 2009 at 12:52:36PM +0100, Pavel Machek wrote:

> I believe that having few nop functions around the tree should not be
> huge problem. If it is, you can introduce one shared top function into
> the core...

The problem I have with that is that for most APIs noop functions are a
big fat warning sign that something is going wrong and the API is being
abused.  This then creates noise and code review problems in the driver
code since you've got something that normally suggests a problem.
