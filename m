From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/2] wm8750: add missing VREF output
Date: Mon, 11 Aug 2008 11:19:40 +0100
Message-ID: <20080811101939.GB5560@sirena.org.uk>
References: <1218444346-19153-1-git-send-email-dbaryshkov@gmail.com>
	<1218444346-19153-2-git-send-email-dbaryshkov@gmail.com>
	<20080811091119.GC9668@rakim.wolfsonmicro.main>
	<48A0025C.6000903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A27D710380C
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Aug 2008 12:19:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48A0025C.6000903@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 11, 2008 at 01:11:56PM +0400, Dmitry Baryshkov wrote:

> It does harm, because it's used in route tables. And as using it as a 
> route dest fails, all further routing mapping aren't ever called.

Hrm, so it is - fairly unusual.

Takashi, this is for stable too.
