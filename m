From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: softvol and snd_pcm_rewind() is broken
Date: Fri, 18 Jul 2008 21:30:17 +0200
Message-ID: <20080718193017.GA28045@tango.0pointer.de>
References: <20080716143004.GA21124@tango.0pointer.de>
	<s5hd4lc3kbw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id D5DCF24560
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 21:30:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hd4lc3kbw.wl%tiwai@suse.de>
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

On Thu, 17.07.08 11:56, Takashi Iwai (tiwai@suse.de) wrote:

> > - And snd_pcm_rewind() might return a value that is higher than was
> >   passed in, which as far as I understood should never happen:
> > 
> >   http://mailman.alsa-project.org/pipermail/alsa-devel/2008-April/007308.html
> > 
> > These two issues might be caused by the same error.
> > 
> > Takashi, Jaroslav, how can I bribe you into fixing this? I'd love to
> > release my new PulseAudio version soon which heavily relies on
> > snd_pcm_rewind(), but unfortunately the most important driver (hda
> > with softvol) makes the most problems with it. :-(
> 
> As mentioned earlier, the softvol itself is a simple plain plugin and
> it has no code to do forward/rewind in itself.  Thus, if a bug is
> present in softvol, it must be in the generic plugin code -- or there
> can be a missing piece that the generic code doesn't cover.  I'm not
> sure yet, as I didn't write that code.
> 
> The second problem, the bigger return size, looks like a thinko in the
> code.  Try the patch below.

I just posted three patches that fix those issues for me. Please have
a look. They do basically what your patch does as well, plus fixing
the return issue.

The patches are trivial, look correct to me and fix the issues.

Please merge,

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
