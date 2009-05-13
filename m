From: mAdVax <madvax@free.fr>
Subject: emu10k1 TRAM access ?
Date: Wed, 13 May 2009 14:53:39 +0200
Message-ID: <4A0AC2D3.5040300@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp23.services.sfr.fr (smtp23.services.sfr.fr [93.17.128.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D605103894
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 14:53:42 +0200 (CEST)
Received: from filter.sfr.fr (localhost [127.0.0.1])
	by msfrf2321.sfr.fr (SMTP Server) with ESMTP id 7F6BC700009F
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 14:53:39 +0200 (CEST)
Received: from [192.168.1.102] (unknown [79.87.161.144])
	by msfrf2321.sfr.fr (SMTP Server) with ESMTP id 57A4F7000095
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 14:53:39 +0200 (CEST)
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

Hello

I would like to send some data to a DSP patch. I can use alsa controls 
(easy) but I need more : TRAM and lookup table. I read many lines of 
code, but all this is still quite obscure...
Here are 3 questions :

How can I fill the TRAM ? (from user space)
How can I know which TRAM area has been allocated to a given patch ?
Do 'lookup tables' work ?

Some code samples will be greatly appreciated  :)

Thanks in advance.

Xavier
