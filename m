From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Fri, 13 Jun 2008 16:48:50 +0200
Message-ID: <20080613144850.GE21255@tango.0pointer.de>
References: <20080609190225.GA4534@tango.0pointer.de>
	<s5h1w333o7r.wl%tiwai@suse.de>
	<20080612205225.GB20818@tango.0pointer.de>
	<s5hd4mlhlau.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806130958000.1798@tm8103-a.perex-int.cz>
	<48524882.6050606@superbug.co.uk> <g2tq3q$969$1@ger.gmane.org>
	<Pine.LNX.4.61.0806131453280.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 8083210381E
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 16:48:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0806131453280.1798@tm8103-a.perex-int.cz>
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

On Fri, 13.06.08 15:06, Jaroslav Kysela (perex@perex.cz) wrote:

> The comment for snd_pcm_delay() in alsa-lib is clear and it's what James 
> wrote. If only one app interprets this wrongly, then I agree it would be 
> better not to change original meaning.
> 
> Then we have snd_pcm_avail_update(). Although it is stated in comment that 
> this function is useless for non-mmap mode, it's quite clear that returns 
> number of available frames to be handled (r/w) by application.
> 
> The easiest method would be just to remove "useless for non-mmap" from 
> comments for snd_pcm_avail_update() and suggest to application developers:
> 
> 1) overall latency is returned by snd_pcm_delay()
> 2) ring buffer filling is controlled by snd_pcm_avail_update(), for 
>    non-mmap access is usage of this function optional
> 
> As mentioned, it will need to fix some drivers mixing software output FIFO 
> with ring buffer (USB, PCMCIA)..
> 
> Opinions?

Sounds good to me, on first sight.

Hmm, however, there is one thing I'd still need for PulseAudio:

I'd like to know when (in time units) the playback buffer would
underrun from now on if I don't write anything anymore. For the USB
driver at least this happens much earlier than just calculating
(buffer_size - snd_pcm_avail_update()) and transforming that into time
units, because the USB driver seems to remove a block at a time from
the playback buffer, and hence it will signal the XRUN much earlier
then the aforementioned value. To fix this I'd need to know what this
granularity is. If I knew that I could fix my sleep time accordingly.

In short: I need some kind of granularity information about
snd_pcm_avail_update() but I must admit that right now I am not
actually sure which parameter would be the best one to know about.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
