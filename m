From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: 'multi' plugin signals POLLOUT
	but	snd_pcm_avail_update() returns 0
Date: Mon, 27 Oct 2008 15:18:36 +0100
Message-ID: <20081027141836.GA24059@tango.0pointer.de>
References: <20081025151429.GA26298@tango.0pointer.de>
	<s5hfxmizbr2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CFD824762
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 15:18:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hfxmizbr2.wl%tiwai@suse.de>
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

On Mon, 27.10.08 09:24, Takashi Iwai (tiwai@suse.de) wrote:

> 
> At Sat, 25 Oct 2008 17:14:29 +0200,
> Lennart Poettering wrote:
> > 
> > Heya!
> > 
> > There's a apparently a bug in the 'multi' plugin. When it is used it
> > will pretty often signal POLLOUT when used with
> > snd_pcm_poll_descriptors_revents() and the subsequent call to
> > snd_pcm_update_avail() will still return 0. Doesn't look right to me.
> 
> Doesn't look right, indeed.
> On which system setup does it happen?

That's surround40:0 on SoundBlaster Live. Here's the debug output of
PA showing this:

https://bugzilla.redhat.com/attachment.cgi?id=321485

(Which belongs to https://bugzilla.redhat.com/show_bug.cgi?id=462200).

Ever line saying "ALSA woke us up to write new data to the device, but
there was actually nothing to write! Most likely this is an ALSA
driver bug. Please report this issue to the PulseAudio developers." is
where we get POLLOUT but update_avail() is 0.

Looking at it it might actually be the hooks module that is broken,
not necessarily "multi".

> Can you reproduce it via a combination of dummy driver so that I can
> test it on my system, too?

Uh. It's not my machine where this happened. But I can try to
reproduce that...

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
