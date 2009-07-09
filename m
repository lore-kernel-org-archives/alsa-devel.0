From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: No incoming sound indigo iox
Date: Fri, 10 Jul 2009 00:42:40 +0200
Message-ID: <20090710004240.560acade@Jay>
References: <30136324.1246980488566.JavaMail.root@elwamui-ovcar.atl.sa.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out113.alice.it (smtp-out113.alice.it [85.37.17.113])
	by alsa0.perex.cz (Postfix) with ESMTP id AC377244FB
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jul 2009 00:45:01 +0200 (CEST)
In-Reply-To: <30136324.1246980488566.JavaMail.root@elwamui-ovcar.atl.sa.earthlink.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Susan Cragin <susancragin@earthlink.net>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 7 Jul 2009 11:28:08 -0400 (EDT)
Susan Cragin <susancragin@earthlink.net> wrote:

> I just purchased the indigoaudio iox.
> Outgoing shows up on Volume Control, incoming does not.
> In Audacity, incoming shows up as: ALSA: Indigo IOx (hw:1,0)
> but recording does not work.
>
> Here's the catch. My problem may be due to my kernel.
> I am running Ubuntu-Studio and have the 29.5-2-rt experimental kernel, which is the 5-1 recompiled with alsadriver support for 30 kernels.
> So you may just tell me to go away until the kernel's better, but I don't think the kernel is the problem.

I don't know what's going wrong. I have the same card and it works. I
didn't try audacity, though. Please do this simple test:

arecord -Dplughw:1 -fcd file.wav


> FYI
> winecfg says:
> fixme:mixer:ALSA_MixerInit No master control found on Indigo IOx, disabling mixer

It hasn't a master volume control. None of the mixer controls of indigo
cards affect recording.


-- 
Giuliano.
