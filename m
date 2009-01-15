From: Hugo Villeneuve <hugo@hugovil.com>
Subject: Re: [PATCH 1/1] ALSA: ASoC: DaVinci: Fix SFFSDR
	compilation error.
Date: Thu, 15 Jan 2009 16:42:00 -0500
Message-ID: <20090115164200.7497a71a.hugo@hugovil.com>
References: <20090108121613.1ef53112.hugo@hugovil.com>
	<1232052035-31846-1-git-send-email-hugo@hugovil.com>
	<200901151323.09869.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.hugovil.com (201-217-static-ppp.3menatwork.com
	[64.235.217.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A29B10388B
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 22:42:01 +0100 (CET)
In-Reply-To: <200901151323.09869.david-b@pacbell.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Brownell <david-b@pacbell.net>
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 15 Jan 2009 13:23:09 -0800
David Brownell <david-b@pacbell.net> wrote:

> On Thursday 15 January 2009, Hugo Villeneuve wrote:
> > Remove dependency on sffsdr_fpga_set_codec_fs() when the
> > SFFSDR FPGA module is not selected.
> > 
> > Signed-off-by: Hugo Villeneuve <hugo@hugovil.com>
> > ---
> 
> Something looks broken in the config you're building with.
> As in, very deeply broken.  You should fix the config instead
> of hacking around those bugs with ifdefs.

Nothing is broken, it is an optional feature.

Hugo.

---------------
Hugo Villeneuve
www.hugovil.com
---------------
