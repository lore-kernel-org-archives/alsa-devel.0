From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ALSA lib troubles with xine
Date: Mon, 3 Sep 2007 10:24:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0709031024070.14792@tm8103.perex-int.cz>
References: <6zk5r8fdev.fsf@odpc25.int.ondemand.co.at>
	<6zd4x0f9q3.fsf@odpc25.int.ondemand.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FBEE24378
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 10:24:49 +0200 (CEST)
In-Reply-To: <6zd4x0f9q3.fsf@odpc25.int.ondemand.co.at>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Markus Korber <korbse@gmx.at>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 3 Sep 2007, Markus Korber wrote:

> Thus spake Markus Korber:
> 
> > I've got problems using ALSA (hg) and xine-lib (1.1.7).  I'm trying to
> > use fbxine for playback but ALSA debug logging gives me:
> > [...]
> > So buffer and period sizes seem to be wrong and therefore I get no
> > sound.  (audio_alsa_out logging from [1].)  Next I've tried to run
> > speaker-test and the ouptut look good:
> 
> Sorry for the wrong information (Must have taken an older version of
> libasound).  I've recompiled alsa-lib 1.0.15rc1 and alsa-utils 1.0.15rc1
> and now speaker-test also fails:

Try compile alsa-lib with '--with-versioned=no' and recompile 
(relink) speaker-test and other apps against this library.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
