From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] sound/soc/au1x: keep pointer to
 resource so it can be freed
Date: Wed, 19 Oct 2011 18:34:14 +0100
Message-ID: <20111019173413.GF4275@opensource.wolfsonmicro.com>
References: <1318909555-12933-3-git-send-email-julia@diku.dk>
	<CAOLZvyFoiuHEfpnozWpAM5h92rjay-asqXX0tY1P1ZzO8eTGOQ@mail.gmail.com>
	<CABS+qY2pBkNjHUKrtD3QttQOQD-LpStHopSGxzeG-iyc7RtVgw@mail.gmail.com>
	<20111019164836.GC4275@opensource.wolfsonmicro.com>
	<Pine.LNX.4.64.1110191930450.31584@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DC81A1039C6
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Oct 2011 19:34:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1110191930450.31584@ask.diku.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia@diku.dk>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Manuel Lauss <manuel.lauss@googlemail.com>, Axel Lin <axel.lin@gmail.com>, "Girdwood, Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 19, 2011 at 07:32:10PM +0200, Julia Lawall wrote:
> I'm not sure how to proceed, since I originally sent 3 patches, all with 
> the same problem.  I send another single patch that fixed the problems 
> with nicer names than r and r1.  Should I send another single patch with 
> Manuel's solution?  Or does Manuel want to do that?

I dunno, I guess sending Manuel's patch along with your other changes
might be the way forward?
