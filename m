From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 4/5] intelhdmi - add channel mapping for
	typical	configurations
Date: Fri, 11 Dec 2009 20:05:18 +0800
Message-ID: <20091211120518.GC7478@localhost>
References: <20091211042832.691808920@intel.com>
	<20091211043213.294570052@intel.com> <s5hiqceov02.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id D634B244B2
	for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2009 13:05:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hiqceov02.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shane W <shane-alsa@csy.ca>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 11, 2009 at 03:00:29PM +0800, Takashi Iwai wrote:
> At Fri, 11 Dec 2009 12:28:36 +0800,
> Wu Fengguang wrote:
> > 
> > IbexPeak is the first Intel HDMI audio codec to support channel mapping.
> > 
> > Currently the outstanding problem is, the HDMI channel order do not
> > agree with that of ALSA.  This patch presents workaround for some
> > typical use cases. It gives priority to the typical ALSA surround
> > configurations, and defines channel mapping for them.
> 
> This looks good.  At least, this can reduce confusions.

Thank you.

> > We may need better kernel+userspace interactive channel mapping scheme.
> > For example, in current scheme if user plays with the surround50 device,
> > the kernel is unaware of this and will still select the surround41
> > channel allocation and channel mapping..
> 
> Yes, more flexible channel mapping is on my TODO list.
> I have a half-finished patch series, but need to rebase and brush up.
> Let's fix it for 2.6.34.

That would be great. The rational I do this patch is, even if we have
some user-space channel mapping facility, it still benefits to be able
to use the hardware capability -- which helps saving power :)

Thanks,
Fengguang
