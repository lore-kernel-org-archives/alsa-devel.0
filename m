From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: 0.9.0rc4 release - D-1 - unresolved symbols
Date: Mon, 21 Oct 2002 20:08:09 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0210212002080.18924-100000@cmn37.stanford.edu>
References: <Pine.LNX.4.33.0210212057560.712-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cm-mail.stanford.edu (cm-mail.Stanford.EDU [171.64.197.135])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id FAA26415
	for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2002 05:09:27 +0200
In-Reply-To: <Pine.LNX.4.33.0210212057560.712-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> 	I've just commited to CVS last change for 0.9.0rc4 (one day to
> launch). I'm sorry for this, but I definitely forgot this topic. As we
> discussed on the list, I've made the change for module options from
> 'snd_xxxx to xxxx'. Please, if you can, test these changes and report any
> fatal problems (compilation, wrong behaviour, description, etc...). Thank
> you very much and have fun with ALSA.

For cvs of 20021021.195736 (US Pacific time)
After installing the drivers I see this:

/sbin/depmod -ae
depmod: *** Unresolved symbols in 
/lib/modules/2.4.19-2.ll.acpi/kernel/drivers/sound/acore/seq/snd-seq.o
depmod: 	snd_seq_default_timer_card
depmod: 	snd_seq_default_timer_resolution
depmod: 	snd_seq_default_timer_sclass
depmod: 	snd_seq_client_load
depmod: 	snd_seq_default_timer_class
depmod: 	snd_seq_default_timer_subdevice
depmod: 	snd_seq_default_timer_device
depmod: *** Unresolved symbols in 
/lib/modules/2.4.19-2.ll.acpi/kernel/drivers/sound/acore/snd.o
depmod: 	snd_device_gid
depmod: 	snd_device_uid
depmod: 	snd_device_mode
depmod: 	snd_major

This also happened earlier today on a ppc build. I'll recheck but I don't 
think I'm missing any files. 

-- Fernando



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of  Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ad.doubleclick.net/clk;4699841;7576298;k?http://www.sun.com/javavote
