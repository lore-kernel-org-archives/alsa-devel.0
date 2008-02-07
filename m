From: Wolfgang Woehl <tito@rumford.de>
Subject: Re: [Jackit-devel] position_fix issue snd-hda-intel
	(was jack issue)
Date: Thu, 7 Feb 2008 21:46:20 +0100
Message-ID: <200802072146.20691.tito@rumford.de>
References: <26670.62.212.109.253.1202065817.squirrel@webmail.nerim.net>
	<200802042339.21846.tito@rumford.de>
	<20080207182521.7363c38a@hypofiz.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186])
	by alsa0.perex.cz (Postfix) with ESMTP id E85E62464F
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 21:46:25 +0100 (CET)
In-Reply-To: <20080207182521.7363c38a@hypofiz.lan>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jackit-devel@lists.sourceforge.net
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Donnerstag, 7. Februar 2008 Stephane THOMAS:

> I found position_fix=3 works for the chip I have (ALC888).
>
> I confirm that with this parameter passed to the module, jack works
> fine. But using ALSA directly produce (? samplerate mismatch).

Just to sum it up:

For, at least, our two snd-hda-intel devices (ALC888 and 82801I (ICH9 
Family)) both position_fix values (POSBUF and FIFO, 0 and 3 
respectively) produce ok sound, only that

position_fix=0 makes alsa fine and jack crackle/sizzle
position_fix=3 makes alsa crackle/sizzle and jack fine

"alsa" meaning direct use of alsa and "jack" meaning (at least in my 
case) jack with the alsa backend.

Here I have alsa-1.0.14-31.2 and jack-0.109.2-0.pm.1 (0.pm.1 stems 
from the packman repository, I guess)

Wolfgang
