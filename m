From: Liam Girdwood <lrg@kernel.org>
Subject: Re: Asoc and alsa utils regarded
Date: Mon, 08 Sep 2008 09:26:58 +0100
Message-ID: <1220862418.17091.61.camel@odin>
References: <b5c34db00809072150w4928030t34a660bfd158d4eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FBAB244D9
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 10:27:02 +0200 (CEST)
In-Reply-To: <b5c34db00809072150w4928030t34a660bfd158d4eb@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: umeshyv <umeshyv@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2008-09-08 at 10:20 +0530, umeshyv wrote:
> Hi to all,
> Currently working on Asoc for Au1200.I need to know whether the framework is
> completed since I see some of the files missing in the all versions of the
> kernel and moreover I am trying to compile alsa libs and utils ,it compiled
> successfully but when I run at the target
> 

What files are missing ? It all works for me.

> sh-3.2# aplay -c1 -r8000 -fs8 Infected.wav
> ALSA lib conf.c:3009:(snd_config_update_r) Cannot
> access file /home/alsa/install/share/alsa/alsa.conf
> ALSA lib pcm.c:2184:(snd_pcm_open_noupdate) Unknown
> 
> PCM default
> aplay: main:583: audio open error: No such file or
> directory

> Do I need to export any PATH at the target.Can anyone guide me.
> 

It looks like your make install did not install all the conf files to
your target.

Please check your build directory for these files and copy across to
your target.

Liam
