From: Glenn Maynard <g_sf@zewt.org>
Subject: Re: [PATCH] Fixes: Re: intel8x0 has stopped working.
Date: Thu, 5 Feb 2004 14:15:22 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040205191522.GE26089@zewt.org>
References: <401E8BAE.6010802@superbug.demon.co.uk> <s5hn081uztv.wl@alsa2.suse.de> <401EA82D.3060702@superbug.demon.co.uk> <401ED94F.7080407@superbug.demon.co.uk> <Pine.LNX.4.58.0402031720190.8251@pnote.perex-int.cz> <40201EFF.9000903@superbug.demon.co.uk> <Pine.LNX.4.58.0402051154080.1864@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from h0040333b7dc3.ne.mediaone.net (postfix@h00045a576c6a.ne.client2.attbi.com [65.96.98.23])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA05919
	for <alsa-devel@alsa-project.org>; Thu, 5 Feb 2004 20:15:26 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402051154080.1864@pnote.perex-int.cz>
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

On Thu, Feb 05, 2004 at 12:01:28PM +0100, Jaroslav Kysela wrote:
> > My point is, I don't think setting start_threshold to buffer_size is 
> > even "wrong" at all. Some people might want the buffer to be full before 
> > it starts, and my patch allows for that.
> 
> It's not wrong semantics. I see - it's logical, but I don't want to follow
> some rule as some API designers does - control magically some things. I
> want that developer which uses our API knows what the library / driver
> exactly does.
> 
> We have clear conditions when the stream is started. That's it.

If this isn't guaranteed to work, I'd suggest making it never work.
Otherwise, programs will work on some hardware and not others, which is
a case that should be minimized as much as possible; it's these kinds
of subtle differences that make it very hard to write reliable (sound,
video, etc) code.  I've had to play games with setting hardware settings:
always set the sample rate even if I don't care, use a 32k buffer size
and not a 4k or 8k one--in order to make it work on as many systems as
possible without failing mysteriously or triggering alsa-lib asserts.

(I don't quite understand why start_threashold == buffer_size doessn't
mean "start when the buffer is full", though.)

-- 
Glenn Maynard


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
