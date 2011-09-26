From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 05/10] ASoC: twl6040: One workqueue should
	be enough
Date: Mon, 26 Sep 2011 22:29:15 +0100
Message-ID: <20110926212914.GE2872@opensource.wolfsonmicro.com>
References: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
	<1317043593-27202-6-git-send-email-peter.ujfalusi@ti.com>
	<20110926144114.GM2946@opensource.wolfsonmicro.com>
	<CAPo=G1yaVVosP=KxH07akYzCuLF6hxP3YGqF0AfH4kHC0bNetw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CF332245FF
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 23:29:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAPo=G1yaVVosP=KxH07akYzCuLF6hxP3YGqF0AfH4kHC0bNetw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 26, 2011 at 08:20:11PM +0300, Ujfalusi, Peter wrote:

> For the ramp code execution we should avoid any delay at all costs, since it can
> have audible side effects.

If you're that sensitive to latency does a workqueue offer sufficient
guarantees?

> In my past experience the system wq can cause latency, since we usually have
> slow devices on it (GPS, proximity sensor, magnetometer, etc).
> Reading from those usually takes considerable amount of time, and
> we can end up with delayed execution of our ramp code.

How long are these work items taking?  I'm wondering if the other work
items are taking sufficiently long to be actively disruptive if they
should be isolated from other things rather than the other way around.
Of course it could also be a large buildup of work...
