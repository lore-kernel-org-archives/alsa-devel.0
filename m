From: William Estrada <MrUmunhum@popdial.com>
Subject: Using GDB for ALSA How to?
Date: Mon, 01 Sep 2008 13:19:54 -0700
Message-ID: <48BC4E6A.1070508@popdial.com>
Reply-To: MrUmunhum@popdial.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from MAIL02.inside.adbasesystems.com (mail.1dial.com [64.136.164.73])
	by alsa0.perex.cz (Postfix) with ESMTP id F1D2224518
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 22:20:10 +0200 (CEST)
Received: from [10.1.1.50] (64.124.13.3.gatespeed.com [64.124.13.3]) by
	MAIL02.inside.adbasesystems.com
	(Vircom SMTPRS 4.5.654.13) with ESMTP id
	<B0591809708@MAIL02.inside.adbasesystems.com> for
	<alsa-devel@alsa-project.org>; Mon, 1 Sep 2008 16:20:07 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi group,

  I am trying to use GDB with my ALSA program. I wish to display (print) 
a handle for
an snd_pcm_t pointer. I am getting the following error:
> (gdb) p Device
> $9 = (snd_pcm_t *) 0x92be458
> (gdb) p *Device
> $10 = <incomplete type>
  How do I display the snd_pcm_t structure?

  Thanks for your time.

-- 
William Estrada
MrUmunhum@popdial.com
Mt-Umunhum-Wireless.net ( http://Mt-Umunhum-Wireless.net )
Ymessenger: MrUmunhum
