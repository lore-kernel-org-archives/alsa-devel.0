From: Ferenc Wagner <wferi@afavant.elte.hu>
Subject: Re: Improving wine support for alsa.
Date: Fri, 07 May 2004 12:12:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3o8yg4zgun.fsf@tba.elte.hu>
References: <20040506234248.GB30822@zewt.org>
	<200405070149.i471nV1F021337@dhin.linuxaudiosystems.com>
	<20040507040214.GK30822@zewt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mx1.elte.hu (mx1.elte.hu [157.181.1.137])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA26952
	for <alsa-devel@alsa-project.org>; Fri, 7 May 2004 12:12:35 +0200
Received: from tba.elte.hu (tba.elte.hu [157.181.170.74])
	by mx1.elte.hu (Postfix) with ESMTP id 3319C276C48
	for <alsa-devel@alsa-project.org>; Fri,  7 May 2004 12:12:01 +0200 (CEST)
Received: from wferi by tba.elte.hu with local (Exim 3.35 #1 (Debian))
	id 1BM2Km-0006nY-00
	for <alsa-devel@alsa-project.org>; Fri, 07 May 2004 12:12:00 +0200
In-Reply-To: <20040507040214.GK30822@zewt.org> (Glenn Maynard's message of
 "Fri, 7 May 2004 00:02:14 -0400")
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

Glenn Maynard <g_sf@zewt.org> writes:

> On Thu, May 06, 2004 at 09:49:31PM -0400, Paul Davis wrote:
>
>> SIGIO is basically useless. your handler executes in
>> signal-handling context, and can do very, very
>> little. not even all system calls are legal in this
>> context.  SIGIO is basically a "poor man's thread
>> system", and not much more.
>
> do you have a reference to system calls which are not
> legal from a signal handler in Linux?

See for example info libc Nonreentrancy and related nodes.
-- 
Feri.


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
