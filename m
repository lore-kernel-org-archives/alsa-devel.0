From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH 1/2] pxa2xx-ac97-lib: move set_resetgpio to
	pxa27x.c
Date: Mon, 25 May 2009 18:21:40 +0800
Message-ID: <f17812d70905250321y4b914bc8r24527b51ff0531e8@mail.gmail.com>
References: <1243243219-23786-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 18C17103839
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 12:21:40 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so1693131qwk.56
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2009 03:21:40 -0700 (PDT)
In-Reply-To: <1243243219-23786-1-git-send-email-dbaryshkov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.miao@marvell.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Mon, May 25, 2009 at 5:20 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> The code related to set_resetgpio is pxa27x specific and should
> not be present in sound driver lib. Move it to appropriate place.
>
> The code is moved to arch/arm as it will be converted from (exported)
> pxa_gpio_mode() calls to use MFP which are unexported to modules.
>

Having thought a while about this, and based on Mark's previous comment,
I'm thinking of moving this code to another place might not be the best choice,
there are two other ways out from my POV:

1. having mfp.c export mfp_config() for external usage
2. or having something like IrDA, i.e. platform specific hooks to make
the driver code generic

I personally prefer way 2) but don't have time for a clean solution yet,
maybe you can help take a look into this. That would be nice.

- eric
