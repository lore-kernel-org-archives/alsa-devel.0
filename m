From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsa dmix 0.9.8 issue
Date: Sun, 16 Nov 2003 11:38:46 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0311161133160.16992@pnote.perex-int.cz>
References: <20031115025729.GB20858@cheney.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA30924
	for <alsa-devel@alsa-project.org>; Sun, 16 Nov 2003 11:38:58 +0100
In-Reply-To: <20031115025729.GB20858@cheney.cx>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Cheney <ccheney@cheney.cx>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 14 Nov 2003, Chris Cheney wrote:

> Jaroslav,
>
> Debian just updated alsa to 0.9.8 recently and so I ran my test
> application against it again. I am still showing that alsa-lib has
> issues when being used with dmix (cmi 8738 hardware) in particular
> when calling snd_pcm_hw_params_set_periods (it fails) when calling
> snd_pcm_hw_params_set_periods_near I get the following information:
>
> periods wanted: 2
> periods dir: 1
> periods got: 2
>
> I told it to set it to periods = 2, it set it to periods = 2, but it
> then said it had set it to an amount of periods greater than what I
> requested (dir = 1), which also indicates when the regular
> snd_pcm_hw_params_set_periods would fail, since alsa-lib thinks it
> couldn't set it to what I requested.
>
> There are more problems using dmix than just this one function such as
> snd_pcm_hw_params_set_buffer_size failing as well.

It's indented to fix broken applications like yours and make them
really ALSA compatible ;-) All ALSA applications must accept also values
which are suggested otherwise it might fail with some hardware. Don't try
to be clever as alsa-lib or the lowlevel driver. You'll fail somewhere.

The dmix works with preset settings in which periods * period_size !=
buffer_size. See _snd_pcm_dmix_open() function (default parameters) for
more details about default values.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
