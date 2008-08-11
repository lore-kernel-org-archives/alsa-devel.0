From: Timur Tabi <timur@freescale.com>
Subject: Re: How to report error in _pointer function?
Date: Mon, 11 Aug 2008 10:37:29 -0500
Message-ID: <48A05CB9.7010205@freescale.com>
References: <ed82fe3e0807300856q6c6daf99n224df8ae4bfe6954@mail.gmail.com>	<s5hhca7s64k.wl%tiwai@suse.de>	<489A1D9E.7040709@freescale.com>	<s5hfxpg6b65.wl%tiwai@suse.de>	<ed82fe3e0808071159k7aea218cm6184680a9c63d3d2@mail.gmail.com>	<s5h1w0z67eq.wl%tiwai@suse.de>	<489CC803.9030408@freescale.com>
	<s5hhc9sm32f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id EADB6245F3
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Aug 2008 17:37:33 +0200 (CEST)
In-Reply-To: <s5hhc9sm32f.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> Hm?  snd_pcm_pre_stop() returns -EBADFD if the stream *IS* OPEN.
> If it's RUNNING, it will stop the stream and change the state.

Hmmm.... you're right.  I don't know what I was thinking.

Tracing the code, I see that ALSA does call my driver's trigger function to stop
the stream.  So why doesn't the application also stop?

-- 
Timur Tabi
Linux kernel developer at Freescale
