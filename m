From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: S24_LE is 3 bytes ? in alsa-lib example pcm.c
Date: Thu, 10 Jul 2008 12:19:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0807101214540.7676@tm8103-a.perex-int.cz>
References: <4875C730.7080003@aimvalley.nl> <4875D4FE.3000607@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id ED7CC24700
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Jul 2008 12:19:09 +0200 (CEST)
In-Reply-To: <4875D4FE.3000607@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
List-Id: alsa-devel@alsa-project.org

On Thu, 10 Jul 2008, Clemens Ladisch wrote:

> Norbert van Bolhuis wrote:
> > as far as I know:
> > sample format S24_LE is 24bit sample in 4 bytes
> > sample format S24_3LE is 24bit sample in 3 bytes
> > (why else have separate definitions), right ?
> 
> Yes.
> 
> > In the ALSA-LIb example /test/pcm.c however
> > (http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2pcm_8c-example.html)
> > there is no diff between the 2 sample formats.
> 
> That example program uses snd_pcm_format_width() although it should
> have used snd_pcm_format_physical_width() when calculating memory
> buffer sizes.

I think that the problem is in wrong area->step calculation in alsa-lib, 
but I'm still investigating where the real culprit is. The
snd_pcm_format_width() is used only for sample filling (which is OK).

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
