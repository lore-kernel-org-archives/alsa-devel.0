From: Heikki Lindholm <holindho@cs.helsinki.fi>
Subject: alsa timestamps
Date: Mon, 19 Nov 2007 09:38:08 +0200
Message-ID: <47413D60.9000404@cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emh01.mail.saunalahti.fi (emh01.mail.saunalahti.fi
	[62.142.5.107]) by alsa0.perex.cz (Postfix) with ESMTP id 47DC2246D0
	for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2007 08:38:10 +0100 (CET)
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id B4EFE1AB17
	for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2007 09:38:09 +0200 (EET)
Received: from marumake.local (a88-112-236-112.elisa-laajakaista.fi
	[88.112.236.112])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id A682A158C15
	for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2007 09:38:08 +0200 (EET)
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

Hello list,

I took up some old dusty code of mine that uses snd_pcm_state followed 
by snd_pcm_status_get_tstamp when in capture mode. The code used to 
work, but now the returned timestamps are all zeroes. Is there some API 
change done recently or is the whole timestamping deprecated or 
something? I've tried with different drivers on ubuntu's alsa .14 and 
gentoo's .14. I've also tried mmap'ed and r/w modes, and I'm setting the 
TSTAMP_MMAP sw param.

-- Heikki Lindholm
