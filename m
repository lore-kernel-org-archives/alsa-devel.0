From: Glenn Maynard <g_sf@zewt.org>
Subject: Re: Improving wine support for alsa.
Date: Fri, 7 May 2004 00:02:14 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040507040214.GK30822@zewt.org>
References: <20040506234248.GB30822@zewt.org> <200405070149.i471nV1F021337@dhin.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from h0040333b7dc3.ne.mediaone.net (postfix@h00045a576c6a.ne.client2.attbi.com [65.96.98.23])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id GAA20287
	for <alsa-devel@alsa-project.org>; Fri, 7 May 2004 06:02:17 +0200
Content-Disposition: inline
In-Reply-To: <200405070149.i471nV1F021337@dhin.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 06, 2004 at 09:49:31PM -0400, Paul Davis wrote:
> at the risk of endlessly repeating myself,

If you're being asked this frequently, I'd recommend adding some notes to
the documentation, recommending using poll() and not SND_PCM_ASYNC, and
offering a brief explanation like this one.

> SIGIO is basically
> useless. your handler executes in signal-handling context, and can do
> very, very little. not even all system calls are legal in this context.
> SIGIO is basically a "poor man's thread system", and not much more.

Practical use aside, isn't that common conditions for a sound callback
(which under some architectures, as I understand it, are called from an
interrupt)?

By the way, do you have a reference to system calls which are not legal
=66rom a signal handler in Linux?  I've never seen things not work in a
signal handler, even when writing a crash handler that forks a child (to
output crash info in a clean environment) and at one point even did some
ptracing of other threads, all from a SIGSEGV handler.

--=20
Glenn Maynard


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
