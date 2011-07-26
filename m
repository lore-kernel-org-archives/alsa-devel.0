From: Tim Blechmann <tim@klingt.org>
Subject: Re: snd_mask_min
Date: Tue, 26 Jul 2011 09:16:31 +0200
Message-ID: <j0lpkf$8ti$1@dough.gmane.org>
References: <j0k9da$p5j$1@dough.gmane.org> <s5hhb6937px.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 23B5F103877
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jul 2011 09:16:43 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Qlbsg-0004PE-RF
	for alsa-devel@alsa-project.org; Tue, 26 Jul 2011 09:16:42 +0200
Received: from 85-127-248-33.dynamic.xdsl-line.inode.at ([85.127.248.33])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2011 09:16:42 +0200
Received: from tim by 85-127-248-33.dynamic.xdsl-line.inode.at with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2011 09:16:42 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> it uses an inline function snd_mask_min, which is declared in
>> sound/pcm_params.h, but this file is not included by sound/pcm.h, where it
>> is defined. including it manually, causes a huge number of errors. it would
>> be very helpful, if pcm.h would be self-contained.
> 
> Well, pcm_params.h is just an additional header that aren't used by
> most drivers, so it doesn't make much sense to include such
> unconditionally from the common pcm.h.

then wouldn't it make sense to move those parts from pcm.h that depend on 
pcm_params.h to that header? especially the params_* family? at the moment pcm.h 
is not self-contained, which is not really what i expect from a header ...

tim
