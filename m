From: John Lindgren <john.lindgren@tds.net>
Subject: Re: snd_pcm_drop causing lockup with DMix
Date: Wed, 03 Mar 2010 07:28:44 -0500
Message-ID: <1267619324.2247.1.camel@satellite>
References: <1267371441.14748.22.camel@satellite>
	<alpine.LNX.2.00.1002281722140.28127@eeebox2.perex-int.cz>
	<1267377313.14982.0.camel@satellite>
	<alpine.LNX.2.00.1003010752570.28127@eeebox2.perex-int.cz>
	<1267487552.11621.2.camel@satellite>
	<alpine.LNX.2.00.1003021423550.28127@eeebox2.perex-int.cz>
	<1267575866.1763.1.camel@satellite>
	<alpine.LNX.2.00.1003031101170.28127@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E16A7103800
	for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2010 13:29:05 +0100 (CET)
Received: by gwj15 with SMTP id 15so634547gwj.38
	for <alsa-devel@alsa-project.org>; Wed, 03 Mar 2010 04:29:04 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1003031101170.28127@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Confirmed, that fixes the hangup.  A minor issue remains that
snd_pcm_writei still always returns -EIO or -EBADFD in this situation.

John Lindgren

On Wed, 2010-03-03 at 11:01 +0100, Jaroslav Kysela wrote:
> This commit should solve this issue:
> 
> http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=b9dbee694a94a724670b36f4df1aeceb0dd4a261
> 
>  					Jaroslav
