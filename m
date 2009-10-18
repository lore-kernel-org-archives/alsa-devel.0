From: Adolf Winterer <adolf.j.winterer@inn-salzach.de>
Subject: Re: Problems with newest alsa driver on 2.6.30 kernel
	- unknown symbols
Date: Sun, 18 Oct 2009 17:41:44 +0200
Message-ID: <200910181741.44329.adolf.j.winterer@inn-salzach.de>
References: <000601ca5001$8f554540$adffcfc0$@de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by alsa0.perex.cz (Postfix) with ESMTP id D1A33243F0
	for <alsa-devel@alsa-project.org>;
	Sun, 18 Oct 2009 17:41:39 +0200 (CEST)
In-Reply-To: <000601ca5001$8f554540$adffcfc0$@de>
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

Am Sonntag 18 Oktober 2009 16:44:55 schrieb Christian Steffen:
> Hi there,
> 
> while an older version of alsa drivers is working fine with my kernel
> 2.6.30, the newly compiled modules can't be inserted properly.
> I compiled snd-had-intel modules for my kernel 2.6.30 and tried to
> insert/start them.
> 
> dmesg returns me:
> 
> [  106.209451] snd_hda_codec: Unknown symbol __snd_printk
> [  106.210340] snd_hda_codec: Unknown symbol snd_hwdep_new
> [  106.212211] snd_hda_codec: disagrees about version of symbol
> snd_pcm_hw_constraint_step
> [  106.212217] snd_hda_codec: Unknown symbol
>  snd_pcm_hw_constraint_step

This is exactly what I'm seeing when I try to compile alsa from the 
1.0.21 sources and try to insert the newly generated modules.
 
> Any idea?

I have no solution, sorry.

Adolf

> Thanks,
> Christian
