From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: uda1380 and pxa255 plays nothing but noise
Date: Tue, 7 Aug 2012 20:26:45 +0100
Message-ID: <20120807192645.GD14711@sirena.org.uk>
References: <50216A11.3050407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id ECF70265FE9
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 20:56:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <50216A11.3050407@gmail.com>
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

On Tue, Aug 07, 2012 at 09:18:41PM +0200, nerwusek wrote:

> I'm trying to enable sound on my iPAQ h2200 device using ALSA ASoC.
> I've created driver basing on hx4700.c and magician.c files, but I
> can't hear is anything. When I am playing music on device file
> uda1380-codec.0-0018/dapm/Playback shows that stream Playback is
> active, but in DAC that stream is inactive (but DAC is on). I also
> noticed that on I2S bus is nothing going on. I've lost many hours on
> looking for problem. Is there anyone who could help me?

Have you checked that the output isn't muted, has the audio routed to
the output you're using and has a suitable volume?
