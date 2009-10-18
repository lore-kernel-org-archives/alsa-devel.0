From: "Christian Steffen" <c-steffen@web.de>
Subject: Re: Problems with newest alsa driver on 2.6.30 kernel
	-	unknown symbols
Date: Sun, 18 Oct 2009 17:47:23 +0200
Message-ID: <000b01ca500a$48ff0cd0$dafd2670$@de>
References: <000601ca5001$8f554540$adffcfc0$@de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate03.web.de (fmmailgate03.web.de [217.72.192.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D868245BE
	for <alsa-devel@alsa-project.org>;
	Sun, 18 Oct 2009 17:47:23 +0200 (CEST)
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 21DB4127390F5
	for <alsa-devel@alsa-project.org>;
	Sun, 18 Oct 2009 17:47:23 +0200 (CEST)
Received: from [78.49.14.78] (helo=Crusoe)
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314) id 1MzXyc-0005F6-00
	for alsa-devel@alsa-project.org; Sun, 18 Oct 2009 17:47:22 +0200
In-Reply-To: <000601ca5001$8f554540$adffcfc0$@de>
Content-Language: de
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

Tried it with the older version 1.0.20, which still gives me one error:

[  190.555043] snd_hda_codec: Unknown symbol snd_hwdep_new

Is there anything to change in the kernel config or whatever?

-----Urspr=FCngliche Nachricht-----
Von: alsa-devel-bounces@alsa-project.org
[mailto:alsa-devel-bounces@alsa-project.org] Im Auftrag von Christian
Steffen
Gesendet: Sonntag, 18. Oktober 2009 16:45
An: alsa-devel@alsa-project.org
Betreff: [alsa-devel] Problems with newest alsa driver on 2.6.30 kernel -
unknown symbols

Hi there,

while an older version of alsa drivers is working fine with my kernel
2.6.30, the newly compiled modules can't be inserted properly.
I compiled snd-had-intel modules for my kernel 2.6.30 and tried to
insert/start them.

dmesg returns me:

[  106.209451] snd_hda_codec: Unknown symbol __snd_printk
[  106.210340] snd_hda_codec: Unknown symbol snd_hwdep_new
[  106.212211] snd_hda_codec: disagrees about version of symbol
snd_pcm_hw_constraint_step
[  106.212217] snd_hda_codec: Unknown symbol snd_pcm_hw_constraint_step


Any idea?

Thanks,
Christian




_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
