From: Glenn Maynard <g_sf@zewt.org>
Subject: Re: [PATCH] fixes Re: problem compiling alsa-lib CVS.
Date: Thu, 1 Apr 2004 16:50:59 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040401215059.GD27390@zewt.org>
References: <405F1A01.8080408@superbug.demon.co.uk> <405F1C2A.1070000@superbug.demon.co.uk> <406B258B.4080106@superbug.demon.co.uk> <Pine.LNX.4.58.0404011041480.1843@pnote.perex-int.cz> <406C03AF.30405@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from h0040333b7dc3.ne.mediaone.net (postfix@h00045a576c6a.ne.client2.attbi.com [65.96.98.23])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA30645
	for <alsa-devel@alsa-project.org>; Thu, 1 Apr 2004 23:51:03 +0200
Content-Disposition: inline
In-Reply-To: <406C03AF.30405@superbug.demon.co.uk>
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

On Thu, Apr 01, 2004 at 12:57:35PM +0100, James Courtier-Dutton wrote:
> >It's better to put this information to configure.in?
> 
> No, because it selects which version of aclocal etc. that are used, 
> which is before configure.in is even looked at.

I would recommend additionally using AC_PREREQ(2.53), which is the
standard way of specifying a minimum version of autoconf.  (I don't know
if there are similar macros for libtool and automake.)

-- 
Glenn Maynard


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
