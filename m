From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] plugin_ops.h fixes
Date: Tue, 09 Jul 2002 13:23:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D2AC7A2.CC29415D@ladisch.de>
References: <3D295521.A14C950@ladisch.de> <s5hadp2v7ni.wl@alsa2.suse.de>
 <3D29C6D0.D0B442F0@libero.it> <3D2AA09B.12C7B125@ladisch.de>
 <3D2AAB9E.C401BD17@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Abramo Bagnara wrote:
> Clemens Ladisch wrote:
> > Abramo Bagnara wrote:
> > > Use of 32/64 bits for 24/32 bit is wanted. Take in account that this
> > > function is called on mix results (where I need to avoid wrap before
> > > normalization).
> >
> > Then it should use bigger types for 8/16 bits, too. Checking for a type
> > to overflow its own valid range seems to be rather pointless to me.
> 
> It *does* use bigger types.

In rev. 1.14 of plugin_ops.h, the beginning of the _norms() function is:

	switch (src_wid) {
	case 8:
		s = *(int8_t*)src;
		if (s >= 0x7f)
			goto _max;
		else if (s <= -0x80)
			goto _min;
		break;
	case 16:
		s = *(int16_t*)src;
		if (s >= 0x7fff)
			goto _max;
		else if (s <= -0x8000)
			goto _min;
		break;

The reads through the src pointer _are_ using 8 and 16 bits.


Anyway, nobody has complained about my changes to _get_triple_*/
get16_1230_B2/put16_labels/gets_*/put_*, so I think these can be
committed now.
Takashi?


Clemens


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Stuff, things, and much much more.
http://thinkgeek.com/sf
