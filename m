From: Tobias Schneider <tobsnyder@gmx.de>
Subject: ALSA Control Questions
Date: Thu, 03 Dec 2009 19:30:38 +0100
Message-ID: <4B1803CE.3080501@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 5DDB6103889
	for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2009 19:30:48 +0100 (CET)
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

I've got some questions concerning the ALSA control interface...

1. What is a "simple" control? I would like to use the control interface 
to set more than just volume (e.g. I would like to set input gain, 
output attenuation, input channel selection, output channel selection, 
output channel activation...), so I am wondering if I should use 
SNDRV_CTL_ELEM_IFACE_CARD or SNDRV_CTL_ELEM_IFACE_MIXER, as they are 
obviously in context with "simple" control...

2. The more interesting question: as written in "Writing an alsa driver" 
callbacks are basically not atomic, but I am getting  BUG: scheduling 
while atomic: amixer/0x00000001/430 Call Trace: .[..] in "put" 
callback?? So what is meant with "basically not atomic"?? What is 
allowed and what is not allowed, am I able to get hardware interrupts in 
this context?
