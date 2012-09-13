From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Need help with WM8960
Date: Thu, 13 Sep 2012 11:31:30 +0800
Message-ID: <20120913033127.GA6732@opensource.wolfsonmicro.com>
References: <5051160C.2010802@freescale.com>
 <20120913024245.GA4467@opensource.wolfsonmicro.com>
 <6AE080B68D46FC4BA2D2769E68D765B7080568F2@039-SN2MPN1-023.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E75D52625CF
 for <Alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 05:31:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <6AE080B68D46FC4BA2D2769E68D765B7080568F2@039-SN2MPN1-023.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 13, 2012 at 03:26:03AM +0000, Tabi Timur-B04825 wrote:
> Mark Brown wrote:

> > No, it's something that the application should do.

> How would the application know to unmute those two particular controls? 
> The only way I figured it out is by launching alsamixer and playing with 
> every control until I heard sound.

The user needs to configure this as part of their system integration.
There's no real way to know what configuration is sane for a given
machine and the user is already doing system integration anyway; putting
things into userspace makes things much easier to maintain.  Even for
something like this we'd need to know if the output is connected to
headphone or line outputs as the volumes configured would generally be
rather different (and of course that can vary at runtime...).
