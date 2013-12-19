From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: wm5110: Add FSH for ISRCs
Date: Thu, 19 Dec 2013 10:32:28 +0000
Message-ID: <20131219103228.GH11138@opensource.wolfsonmicro.com>
References: <1387445413-28475-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20131219102023.GQ31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1D84C261AA5
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 11:32:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131219102023.GQ31886@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 19, 2013 at 10:20:23AM +0000, Mark Brown wrote:
> On Thu, Dec 19, 2013 at 09:30:12AM +0000, Charles Keepax wrote:
> > Currently, the driver only supports configuration of the lower sample
> > rate (FSL) on the ISRCs. With the higher rate being fixed a SYSCLK, this
> > patch adds support for configuring the higher sample rate (FSH).
> 
> Applied both but you guys should really be doing some work to support
> this within the framework and propagate rates through the devices.

Yeah I agree, we have scheduled some time in January to look at
doing so, so with a bit of luck you should start to see something
moving on that front around then.

Thanks,
Charles
