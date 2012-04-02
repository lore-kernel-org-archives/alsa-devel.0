From: "Paul D. DeRocco" <pderocco@ix.netcom.com>
Subject: Re: Rawmidi vs. /dev/snd/*
Date: Mon, 2 Apr 2012 10:02:15 -0700
Message-ID: <95AF842A4173430D8AE58F407A47467A@PAULD>
References: <4F7995F2.9040508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from elasmtp-galgo.atl.sa.earthlink.net
	(elasmtp-galgo.atl.sa.earthlink.net [209.86.89.61])
	by alsa0.perex.cz (Postfix) with ESMTP id A949424374
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Apr 2012 19:01:53 +0200 (CEST)
In-Reply-To: <4F7995F2.9040508@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "'Gabriel M. Beddingfield'" <gabrbedd@gmail.com>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> From: Gabriel M. Beddingfield [mailto:gabrbedd@gmail.com] 
> 
> It would be a good idea for you to check out the alsa-lib sources and 
> snoop around in the src/rawmidi/ folder.
> 
> In reality, only one file descriptor is returned by 
> snd_rawmidi_poll_descriptors().  However, the API returns an array so 
> that it can expand in the future without having to recompile programs 
> linked to the library.
> 
> Yes, the ALSA documentation sucks.  But I assure you that if 
> you try to 
> use the raw kernel interface... the documentation is worse. :-)

Since ALSA is big an complicated, and since my embedded system will probably
be based on SALSA, I downloaded that source, which is comparatively simple
(hence the S, I guess). It makes it clear what's going on: the RawMidi
handle already contains a pollfd for its internal use, and
snd_rawmidi_poll_descriptors makes that available to the app.

Thanks for your time.

-- 

Ciao,               Paul D. DeRocco
Paul                mailto:pderocco@ix.netcom.com 
