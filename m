From: Marek Peca <marek@duch.cz>
Subject: Should snd_pcm_drop() interrupt snd_pcm_writei() call?
Date: Tue, 12 May 2009 18:46:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0905121806240.8364@tesla>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from max.feld.cvut.cz (max.feld.cvut.cz [147.32.192.36])
	by alsa0.perex.cz (Postfix) with ESMTP id C596C10386F
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 19:41:05 +0200 (CEST)
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id 5F39E19F3303
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 19:41:04 +0200 (CEST)
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new,
	port 10044)
	with ESMTP id RJXrB73uwrMS for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 19:40:59 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id B065419F336C
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 19:40:59 +0200 (CEST)
Received: from k335-169.felk.cvut.cz (k335-169.felk.cvut.cz [147.32.86.169])
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 3BEE4FA003
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 19:40:54 +0200 (CEST)
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

I would like to know, how should snd_pcm_drop() call influence 
snd_pcm_writei() being simultaneously executed.

I expected, that after issuing snd_pcm_drop() (from another thread), the 
snd_pcm_write*() in progress should be terminated almost immediately with 
some return value (error or short write). According to my observation, 
this seem to work on ALSA lib & driver 1.0.14rc3, snd_ali5451.

However, it never or almost never works on another machine with ALSA lib 
1.0.16 (Debian package libasound2 [1.0.16-2], driver unknown, sorry).
There, the snd_pcm_write*() _never_returns_ after snd_pcm_drop(), and 
remain stuck forever.

I would like to ask you, which behaviour of snd_pcm_drop/snd_pcm_write* is 
the correct one. I suppose the snd_pcm_write*() should be interrupted, 
otherwise, an extra thread would be needed in many applications. However, 
I don't know, why does not it work in the later version of ALSA.

I have not found the answer in Doxygen, and since I am real ALSA newbie, I 
gave up reading ALSA source, especially because I have seen different 
behaviour among two different versions. Excuse my impatience.


Thank you for a clarification.
Best regards,
  Marek.
