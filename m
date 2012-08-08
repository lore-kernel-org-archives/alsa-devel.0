From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: uda1380 and pxa255 plays nothing but noise
Date: Wed, 8 Aug 2012 10:57:47 +0100
Message-ID: <20120808095747.GF14711@sirena.org.uk>
References: <50216A11.3050407@gmail.com> <20120807192645.GD14711@sirena.org.uk>
 <50216F4E.1040201@gmail.com>
 <CA+E=qVeeOhXB7iF_BFEp0FpguJQaUhV2nz_0HR4vxnwsMVXJ6Q@mail.gmail.com>
 <50218D28.1080404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A8CBD265E37
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2012 11:28:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <50218D28.1080404@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: nerwusek <luk0104@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 07, 2012 at 11:48:24PM +0200, nerwusek wrote:

> When I change volume of Analog Mixer the noise in headphones is
> getting stronger or weaker so GPIOs in my opinion are set up correctly.

This sounds like either the CPU isn't actually sending data or there's a
digital mute.
