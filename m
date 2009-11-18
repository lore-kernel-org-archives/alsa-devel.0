From: Adolf Winterer <adolf.j.winterer@inn-salzach.de>
Subject: Status of ALSA support for MacBook Pro 5,
	2 in kernel 2.6.32
Date: Wed, 18 Nov 2009 12:23:16 +0100
Message-ID: <200911181223.16905.adolf.j.winterer@inn-salzach.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 65B97103943
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 12:21:59 +0100 (CET)
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


Hello,

there had been a lot of messages here on the list and in other internet 
sources about patches to snd-hda-intel regarding the sound support for 
MacBook Pro 5,1 and MacBook Pro 5,2. But the situation is far from being 
clear.

Some sources stated that the patches for the MacBook Pro 5,1 would 
support the MacBook Pro 5,2 as well, others disagreed.

Recently on this list I've seen efforts to integrate the current ALSA 
1.0.21+x into kernel 2.6.32. 

Fact is that with kernel 2.6.30-2, which has ALSA 1.0.20, from Debian 
testing my MacBook Pro 5,2 is not working. There is no sound at all. 

Compilation of ALSA sources 1.0.21 using the module assistant fails with 
an error message regarding a missing curly bracket. There is a bug 
report in the Debian bug tracker regarding this, but no progress is 
visible.

Compiling the sources directly using the 1.0.21 sources from the ALSA 
project page goes through, but the resulting modules do not load, give 
an error message about an unknown symbol. Therefore I was not able to 
find out if ALSA 1.0.21 supports the MacBook Pro 5,2.

Please, can anyone of the development team help with a statement 
clearing up things by answering the following questions?

* Will the support for the MacBook Pro 5,2 be part of the soon to be 
released kernel 2.6.32?
* Or is it already present in kernel 2.6.31?
* What is the correct parameter for the loading of the module? Is it 
just "auto" or "mb5"? Or anything else?

Your help is greatly appreciated.

Best regards,
Adolf
