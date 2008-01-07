From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Status of snd_pcm_rewind()
Date: Mon, 7 Jan 2008 16:14:58 +0100
Message-ID: <20080107151458.GB14386@tango.0pointer.de>
References: <20071222183301.GA3733@tango.0pointer.de>
	<s5hmyrh91bx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C7B124928
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 16:14:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hmyrh91bx.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 07.01.08 15:06, Takashi Iwai (tiwai@suse.de) wrote:

> 
> At Sat, 22 Dec 2007 19:33:01 +0100,
> Lennart Poettering wrote:
> > 
> > Hi!
> > 
> > What's the status of snd_pcm_rewind()? Is it available on all devices?
> 
> It should work on all "hw" PCM, but not via every plugin.  The
> functionality is basically in the PCM core level, independent from
> the lowlevel driver implementation.
> 
> dmix and dshare don't work (unimplemented).  The other plugins should
> work, though.
> 
> > I assume not (at least dmix doesn't...). But I guess I can safely
> > assume it is available when mmap is used? Is there any API function to
> > test if it is available?
> 
> No, unfortunately.  A self-test?

Ii assume th "No" is a response to the question if there was any API
function to test whether it is available, right?

What's the answer to the question that I can safely assume that it is
available when mmap is used?

May I suggest adding an API function that can be used to detect
whether _rewind() functionality is available?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
