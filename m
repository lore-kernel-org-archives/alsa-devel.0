From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: HG -> GIT migration
Date: Wed, 21 May 2008 08:09:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0805210805080.1798@tm8103-a.perex-int.cz>
References: <Pine.LNX.4.61.0805201314190.1798@tm8103-a.perex-int.cz>
	<200805211430.06653.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id D622924490
	for <alsa-devel@alsa-project.org>;
	Wed, 21 May 2008 08:09:17 +0200 (CEST)
In-Reply-To: <200805211430.06653.linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 21 May 2008, Eliot Blennerhassett wrote:

> On Tuesday 20 May 2008 23:21:13 Jaroslav Kysela wrote:
> > Hi all,
> >
> > 	I finished migration from HG to GIT. All repositories are
> > converted and we have one "new" repository - alsa-kernel.git which is full
> > Linux 2.6 GIT tree. The old HG alsa-kernel repository was renamed to
> > alsa-kmirror 
> 
> Hi Jaroslav,
> 
> can you clarify what one should do to be able to build latest GIT head.

I built alsa-driver with latest Linux 2.6 tree without any problems.

> Should I expect the following to work? (as it used to work with Hg)
> 
> $ git clone git://git.alsa-project.org/alsa-kmirror.git alsa-kmirror  
> $ git clone git://git.alsa-project.org/alsa-driver.git alsa-driver  
> $ cd alsa-driver
> $ ALSAKERNELDIR=../alsa-kmirror/ ./gitcompile --with-debug=full   

It's not required to set ALSAKERNELDIR to ../alsa-kmirror - it's default 
now.

> anyway I get this error
> 
>   CC [M]  /home/eliot/src/alsagit/alsa-driver/i2c/other/pt2258.o
> make[4]: *** No rule to make target 
> `/home/eliot/src/alsagit/alsa-driver/i2c/other/tea575x-tuner.o', needed by 
> `/home/eliot/src/alsagit/alsa-driver/i2c/other/snd-ak4117.o'.  Stop.

It seems that we have a problem with this patch:

Author: Takashi Iwai <tiwai@suse.de>
Date:   Fri May 2 12:31:51 2008 +0200

    [ALSA] fm801 - Fix kconfig dependency mess of fm801-tea575x

    FM801-tea575x tuner has a reverse selection to V4L1 and this causes
    nasty dependency problems.

    The patch simplifies the dependency with a normal
    "depends on VIDEO_V4L1".  This decreases the usability but fixes bugs,
    yeah.  If any better feature like "requires" is introduced to kbuild
    in future, we'll be able to switch it...

    Signed-off-by: Takashi Iwai <tiwai@suse.de>

Do you have enabled SND_VIDEO_V4L1 in your kernel's .config?

						Jaroslav


-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
