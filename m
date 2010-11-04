From: Matthew Gregan <kinetik@flim.org>
Subject: Re: Hang in snd_pcm_writei with alsa-pulse plugin
Date: Thu, 4 Nov 2010 16:52:56 +1300
Message-ID: <20101104035256.GA21847@flim.org>
References: <20101101013819.GA22823@flim.org>
	<AANLkTinxDcSmpRfvp560AzzG3a-5BX9RdVfiG2qLzqiD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from flim.org (flim.org [65.99.223.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 9139F103844
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 04:53:02 +0100 (CET)
Received: from brak (unknown [121.98.132.55])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by flim.org (Postfix) with ESMTPSA id 46D141438F
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 03:52:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <AANLkTinxDcSmpRfvp560AzzG3a-5BX9RdVfiG2qLzqiD@mail.gmail.com>
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

At 2010-11-04T11:29:39+0800, Raymond Yau wrote:
> when increase the sleep time from half period to one period, the hang occur
> after around 50 pause/resume cycles.
> 
> did PA server  stop sending data to the sound card immediately when your
> program pause ?

Yes.  As far as I can tell, at least.

> But cannot reproduce your problem using the "pause" function of aplay
> 
> which sound card are you using and did you change the pulseaudlo daemon.conf
> ?

I'm using the default daemon.conf shipped with Fedora 13, which contains
nothing but comments and newlines.  The sound card is: Intel Corporation 5
Series/3400 Series Chipset High Definition Audio (rev 06) in a Lenovo W510.
I've seen this problem on other machines (including in VMWare and VirtualBox
based VMs) too, but I don't know what sound hardware they were using.

Cheers,
-mjg
-- 
Matthew Gregan                     |/
                                  /|                    kinetik@flim.org
