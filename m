From: Glenn Maynard <g_sf@zewt.org>
Subject: Re: [PATCH] Fixes: Re: intel8x0 has stopped working.
Date: Thu, 5 Feb 2004 14:58:10 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040205195810.GF26089@zewt.org>
References: <401E8BAE.6010802@superbug.demon.co.uk> <s5hn081uztv.wl@alsa2.suse.de> <401EA82D.3060702@superbug.demon.co.uk> <401ED94F.7080407@superbug.demon.co.uk> <Pine.LNX.4.58.0402031720190.8251@pnote.perex-int.cz> <40201EFF.9000903@superbug.demon.co.uk> <Pine.LNX.4.58.0402051154080.1864@pnote.perex-int.cz> <20040205191522.GE26089@zewt.org> <Pine.LNX.4.58.0402052030370.1864@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from h0040333b7dc3.ne.mediaone.net (postfix@h00045a576c6a.ne.client2.attbi.com [65.96.98.23])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA07033
	for <alsa-devel@alsa-project.org>; Thu, 5 Feb 2004 20:58:14 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402052030370.1864@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 05, 2004 at 08:38:23PM +0100, Jaroslav Kysela wrote:
> > Otherwise, programs will work on some hardware and not others, which is
> > a case that should be minimized as much as possible; it's these kinds
> > of subtle differences that make it very hard to write reliable (sound,
> > video, etc) code.  I've had to play games with setting hardware settings:
> > always set the sample rate even if I don't care, use a 32k buffer size
> > and not a 4k or 8k one--in order to make it work on as many systems as
> > possible without failing mysteriously or triggering alsa-lib asserts.
> 
> Send us bug-reports if you have problems. We have not a magic ball.

Sample rate issue:

Subject: pcm_plug.c:882: snd_pcm_plug_hw_params: Assertion `err >= 0' failed.
Message-ID: <20031224003200.GB25270@zewt.org>

Buffer size issue:

Subject: CS46xx oddness
Message-ID: <20031224094213.GE25270@zewt.org>

In retrospect, the CS46xx issue looks just like a symptom of this
problem: the buffer fills up and never starts.  (I'm not setting
start_threshold at all, and regardless of the buffer size I only write
up to 4k ahead.)  I don't have this card to actually test with, though.

> Because we have the avail_min threshold which says that we don't want to
> write new data when buffer can accept less samples than this threshold. So
> if start_threshold is greather than '(buffer_size / avail_min) *
> avail_min' expression, then stream won't be automatically started, because
> we cannot fill data in read/write operations to satisfy the requirement
> that start_threshold == buffer_size.
> 
> Isn't this clear and right?

I don't know if avail_min is forced by hardware, but xfer_align (Takashi's
explanation) is.  It's easy for a program written on a system with a small
xfer_align to mysteriously not work on a system with a large xfer_align,
resulting in bug reports like "sound doesn't play".  Reporting an error
in cases where sound would never start is helpful.

-- 
Glenn Maynard


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
