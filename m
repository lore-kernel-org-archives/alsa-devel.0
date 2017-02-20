From: Simon Ho <simon.ho.cnxt@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: cx2092x: Add DT bingings doc for
	CX2092X DSP
Date: Mon, 20 Feb 2017 09:42:47 +0800
Message-ID: <20170220014247.GA24076@GMAIL.COM>
References: <1487427991-18174-1-git-send-email-simon.ho@conexant.com>
 <1487427991-18174-2-git-send-email-simon.ho@conexant.com>
 <20170219162049.3ezlsqoyagrwfzmw@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 51FAF26583C
 for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2017 02:42:55 +0100 (CET)
Received: by mail-pg0-f66.google.com with SMTP id 1so3577078pgz.2
 for <alsa-devel@alsa-project.org>; Sun, 19 Feb 2017 17:42:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170219162049.3ezlsqoyagrwfzmw@sirena.org.uk>
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
Cc: Simon Ho <simon.ho@conexant.com>, alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 19, 2017 at 04:20:49PM +0000, Mark Brown wrote:
> On Sat, Feb 18, 2017 at 10:26:30PM +0800, simon.ho.cnxt@gmail.com wrote:
> 
> > +  - reset-gpio:  A GPIO spec to define which pin is connected to the chip's
> > +                 !RESET pin. If specified, the driver will assert a hardware
> > +                 reset at probe time.
> 
> The DT people say all GPIO specifier names have to be pluralised so this
> needs to be -gpios even if there's only one GPIO.

Thanks for input, I chnaged the name to -gpios.

-Simon
