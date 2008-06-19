From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Thu, 19 Jun 2008 19:59:07 +0200
Message-ID: <20080619175907.GA8785@tango.0pointer.de>
References: <s5h1w333o7r.wl%tiwai@suse.de>
	<20080612205225.GB20818@tango.0pointer.de>
	<s5hd4mlhlau.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806130958000.1798@tm8103-a.perex-int.cz>
	<s5hr6b1qrri.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806131733180.1798@tm8103-a.perex-int.cz>
	<s5hmylpqq9z.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806131813150.1798@tm8103-a.perex-int.cz>
	<4852D095.1000508@superbug.co.uk>
	<Pine.LNX.4.61.0806161329250.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EBF724362
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jun 2008 19:59:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0806161329250.1798@tm8103-a.perex-int.cz>
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

On Mon, 16.06.08 14:07, Jaroslav Kysela (perex@perex.cz) wrote:

> 
> Hi all,
> 
> 	I tried to describe expressions for all values as Lennart proposed 
> with current snd_pcm_avail_update() / snd_pcm_delay() functions and add 
> some more comments to things noted in this discussion. I do not think that 
> we should make internal ring buffer pointers external for
> applications.

BTW, i changed my mind on this one. I now agree that exporting the
pointers is a bad idea, because they are not sufficient to detect the
length of buffer underruns that are more than one buffer size
long. However snd_pcm_avail_updates() informs properly about
those. Hence I think exporting the pointers just like that is a bad idea.

> * LEFT_TO_PLAY:   similar to WRITE_TO_HEAR but callable *after* we
>   wrote something, and it will return how much of what we wrote has not
>   been heard yet. In contrast to WRITE_TO_HEAR this will return 0
>   eventually.
> - this accouting can be easily done in app using snd_pcm_delay() - 
>   application know how many samples were written

This one is actually much more complex. If you want to do it properly
you need to save snd_pcm_delay() before you write something and than
subtract the time passed since that point of time. However the problem
here is that the time passed since then you only get in the system
time domain, while snd_pcm_delay() is in sound card time domain. So
doing this properly is difficult. If you don't care about correctness
you can of course ignore the different timing sources and then the
calculation isn't that difficult anymore.

> int snd_pcm_avail_and_delay(snd_pcm_t *,
> 			    snd_sframes_t *avail, 
> 			    snd_sframes_t *delay);
> 	/* hwsync() + avail_update() + delay() - atomic operation */

This sounds good to me.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
