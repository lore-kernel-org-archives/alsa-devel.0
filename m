From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] plugin_ops.h fixes
Date: Thu, 11 Jul 2002 10:37:03 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0207110934460.496-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.33.0207101418080.504-100000@pnote>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0207101418080.504-100000@pnote>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> I've fixed the normalization (hopefully) for int64 and float values. Could
> you, guys, verify new code?

In the following test

	else if (sum.as_xxx < (int64_t)-0x80000000)

0x80000000 is an unsigned integer, and, according to C rules, negating an
unsigned integer results in an unsigned integer, in this case 0x80000000.
Converting this to 64 bits yields 0x0000000080000000. *Ouch*

Replacing both tests with

	else if (sum.as_xxx < (int64_t)(int32_t)0x80000000)

should finally work.


And
> > > (...) the following code snippet
> > >
> > >         add_int64_att:
> > >                 sum.as_sint64 += (u_int64_t) sample * ttp->as_int;
> > >
still treats the sample as unsigned.


Clemens



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
PC Mods, Computing goodies, cases & more
http://thinkgeek.com/sf
