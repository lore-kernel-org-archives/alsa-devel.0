From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] pcm_ladspa: add support for softfloat
Date: Wed, 7 Jan 2009 11:11:14 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0901071109380.8273@tm8103.perex-int.cz>
References: <1231322810-5973-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id D05AC1037EE
	for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2009 11:11:14 +0100 (CET)
In-Reply-To: <1231322810-5973-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 7 Jan 2009, Mike Frysinger wrote:

> The ladspa module uses math functions unconditionally which breaks when
> building with --with-softfloat.  Tweak the code to only call the math
> functions when HAVE_SOFT_FLOAT is not defined.

It would be better to disable building of ladspa plugin when soft-float is 
enabled completely as Takashi already proposed. LADSPA works only with 
float samples which does not make much sense for soft-float platforms.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
