From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Fri, 13 Jun 2008 20:48:32 +0200
Message-ID: <20080613184831.GC1954@tango.0pointer.de>
References: <s5h1w333o7r.wl%tiwai@suse.de>
	<20080612205225.GB20818@tango.0pointer.de>
	<s5hd4mlhlau.wl%tiwai@suse.de>
	<20080613142526.GB21255@tango.0pointer.de>
	<s5hod65qqhh.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806131800160.1798@tm8103-a.perex-int.cz>
	<s5hhcbxqp1y.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806131835180.1798@tm8103-a.perex-int.cz>
	<s5h8wx9qnv0.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806131900590.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 42B5B244EF
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 20:48:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0806131900590.1798@tm8103-a.perex-int.cz>
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

On Fri, 13.06.08 19:37, Jaroslav Kysela (perex@perex.cz) wrote:

> It means that the PCM midlevel code thinks that samples in URBs are 
> played (underrun can be detected), but they are queued in URBs.
> 
> OK, my fault. It's exactly behaviour I proposed (URBs are extra buffers), 
> but we need to take in account the right snd_pcm_delay() output. Lennart 
> probably meant that samples are consumed too much quickly at the stream 
> start and impossibility to detect the extra buffering mechanism with the 
> current code.

Yes, this is exactly what I am experiencing. At stream start my
estimations (based on update_avail) are way off. Afterwards everything
is fine. As a dirty workaround to fix this I halve the initial sleep
time always so that I can make sure I don't sleep for too long and get
an xrun. But that's really ugly, because halving it is just a wild
guess and it isn't even necessary on PCI hardware.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
