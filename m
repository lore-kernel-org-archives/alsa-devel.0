From: Florian Faber <faber@faberman.de>
Subject: Re: RME HDSP rev 37 does not work on 64-bit linux
Date: Mon, 2 Feb 2009 09:35:35 +0100
Message-ID: <200902020935.35530.faber@faberman.de>
References: <70a871c80902010708s2a10ff8bobe79622949da62fe@mail.gmail.com>
	<200902011616.49454.faber@faberman.de>
	<70a871c80902010846i1059ab26t63c1d7e530126caf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de (india820.server4you.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id AF4102442C
	for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2009 09:35:38 +0100 (CET)
In-Reply-To: <70a871c80902010846i1059ab26t63c1d7e530126caf@mail.gmail.com>
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
To: alsa-devel@alsa-project.org
Cc: Dmitry Baikov <dsbaikov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Dmitry,

> I just revived my 64-bit Gentoo partition, and vanilla 2.6.28.2 says
> No Multiface or Digiface found, disabling the card.

Ok, you are using a notebook. I have seen problems with notebooks when the 
period between powering up the cardbus socket and trying to access the card 
wasn't long enough, the interface card isn't initialized fast enough.

Please try the following: Go to line 5059 in /sound/pci/rme9652/hdsp.c and 
change the line
	ssleep(2);
to
	ssleep(5);

Compile it and try again.


Flo
-- 
Machines can do the work, so people have time to think.
public key 6C002249          x-hkp://wwwkeys.eu.pgp.net
