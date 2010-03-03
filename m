From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: snd_pcm_drop causing lockup with DMix
Date: Wed, 3 Mar 2010 13:59:07 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003031352200.28127@eeebox2.perex-int.cz>
References: <1267371441.14748.22.camel@satellite>
	<alpine.LNX.2.00.1002281722140.28127@eeebox2.perex-int.cz>
	<1267377313.14982.0.camel@satellite>
	<alpine.LNX.2.00.1003010752570.28127@eeebox2.perex-int.cz>
	<1267487552.11621.2.camel@satellite>
	<alpine.LNX.2.00.1003021423550.28127@eeebox2.perex-int.cz>
	<1267575866.1763.1.camel@satellite>
	<alpine.LNX.2.00.1003031101170.28127@eeebox2.perex-int.cz>
	<1267619324.2247.1.camel@satellite>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id E3F64103940
	for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2010 13:59:07 +0100 (CET)
In-Reply-To: <1267619324.2247.1.camel@satellite>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Lindgren <john.lindgren@tds.net>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 3 Mar 2010, John Lindgren wrote:

> Confirmed, that fixes the hangup.  A minor issue remains that
> snd_pcm_writei still always returns -EIO or -EBADFD in this situation.

I don't see a problem here. If transfer is stopped, the pcm handle is 
not initialized for I/O transactions, thus upper layers return these 
errors.

Your application should check snd_pcm_state() in case of error and look if 
stream is inactive (back in SND_PCM_STATE_SETUP), because your application 
invoked the drop() call.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
