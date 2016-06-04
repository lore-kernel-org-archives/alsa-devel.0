From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: [PATCH] ASoC: sgtl5000: only check VDDD-supply,
	not revision
Date: Sat, 4 Jun 2016 11:03:24 +0200
Message-ID: <20160604090324.GA867@archie.localdomain>
References: <20160602124724.7725-1-clemens.gruber@pqgruber.com>
 <CAOMZO5B20n7Tu3r+BsU2R5BbYj41tf7qBsMLRWxChdWMkHxLNQ@mail.gmail.com>
 <5751AEF6.40200@nelint.com> <575264A4.2070709@nelint.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.pqgruber.com (mail.pqgruber.com [178.189.19.235])
 by alsa0.perex.cz (Postfix) with ESMTP id 43BB22606D6
 for <alsa-devel@alsa-project.org>; Sat,  4 Jun 2016 11:03:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <575264A4.2070709@nelint.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Nelson <eric@nelint.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Eric,

On Sat, Jun 04, 2016 at 07:18:28AM +0200, Eric Nelson wrote:
> AFAIK, the SGTL5000 versions < 0x11 are like Sasquatch: I've seen
> no real proof of their existence. I tried to chase down when this
> code was introduced, but it seems to have been around since
> the dawn of the driver.

> 
> Clemens, if you're really trying to control an external regulator,
> I think you'll need lots more than this patch. There are some
> fundamental flaws in regulator handling and I put together some
> RFC patches to address them in February 2015:
> 	http://mailman.alsa-project.org/pipermail/alsa-devel/2015-February/thread.html#88353
> 
> The long and short of it is that at least one of the regulators
> would need to be initialized before the SGTL5000 probes.

Thank you very much for your input on this. So we can assume that no
user of the sgtl5000 is controlling an external VDDD regulator, because
this does not work without your patch series from Februar 2015.

As far as not enabling the internal LDO when using external VDDD and
avoiding the misleading "Using internal LDO..." message at boot, do you
think my patch would be OK?

Regards,
Clemens
