From: Marek Peca <marek@duch.cz>
Subject: Re: Should snd_pcm_drop() interrupt snd_pcm_writei()
	call?
Date: Fri, 15 May 2009 15:57:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0905151555550.3095@tesla>
References: <Pine.LNX.4.64.0905121806240.8364@tesla>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from max.feld.cvut.cz (max.feld.cvut.cz [147.32.192.36])
	by alsa0.perex.cz (Postfix) with ESMTP id A503F24493
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 16:52:46 +0200 (CEST)
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id 968BB19F33D9
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 16:52:46 +0200 (CEST)
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new,
	port 10044)
	with ESMTP id nDUty+KxW8GH for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 16:52:41 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 4230619F33CF
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 16:52:41 +0200 (CEST)
Received: from 192.168.10.2 (unknown [77.104.221.55])
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 1DB59FA003
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 16:52:36 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0905121806240.8364@tesla>
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

> I would like to know, how should snd_pcm_drop() call influence 
> snd_pcm_writei() being simultaneously executed.
>
> I expected, that after issuing snd_pcm_drop() (from another thread), the 
> snd_pcm_write*() in progress should be terminated almost immediately with 
> some return value (error or short write).
> (..)


Today, Jara Kysela told me, that calling pcm functions from multiple 
threads is not recommended practice.

This explains the problems I encountered. I missed the information, that 
these functions are not meant to be thread-safe.


Best regards,
Marek.
