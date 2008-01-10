From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC] virtual master control for HD-audio
Date: Thu, 10 Jan 2008 16:43:24 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0801101639200.30240@tm8103.perex-int.cz>
References: <s5hprx12x6x.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0712212030470.8567@tm8103.perex-int.cz>
	<s5hd4syu6co.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0801101027300.30240@tm8103.perex-int.cz>
	<s5hzlvdaoin.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0801101421390.30240@tm8103.perex-int.cz>
	<s5hmyrdafp4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D032245E3
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 16:43:25 +0100 (CET)
In-Reply-To: <s5hmyrdafp4.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 10 Jan 2008, Takashi Iwai wrote:

> > I'm sure I can hack smixer - simple_none.c - to add virtual master support 
> > in few days. If I fail for a reason or code is really ugly, I give you my 
> > ack for your implementation, ok?
> 
> Well, as I wrote, smixer alone won't solve all the corner cases.
> Imlementing smixer would be relatively easy.  But it can't be solid
> like the kernel driver, and we have still problems with control API
> and kernel mixer OSS.

Ok, I switch to rather neutral mode in this issue. Although I don't think 
that it's the right solution. You can commit this code to repo. Time shows 
us if it was good or not. Back to coding.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
