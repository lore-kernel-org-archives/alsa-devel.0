From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Dynamically allocate the rtd
	device	for a non-empty release
Date: Mon, 9 Jan 2012 21:14:18 +0000
Message-ID: <20120109211418.GC30766@opensource.wolfsonmicro.com>
References: <1326092550-22306-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hd3atkwrj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D2A182446D
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 22:14:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hd3atkwrj.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Greg KH <greg@kroah.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 09, 2012 at 11:14:56AM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > Greg, you asked for this to be included in 3.3 but I really don't see
> > any reason for doing so - this isn't exactly new code and there aren't
> > any practical issues being reported.  Is there any actual rush?

> Since it's no urgent fix, rc1 is the best merge point.  Of course, I
> know it's a bit too late for merge, but the code doesn't look so
> awfully intrusive.  So, I find it's OK.

I'm still not thrilled by it but whatever.
