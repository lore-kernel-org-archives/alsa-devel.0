From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: build error in pcm_native.c
Date: Fri, 16 Jul 2004 15:37:01 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0407161524370.12830-100000@studcom.urz.uni-halle.de>
References: <s5hn0206yaq.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5hn0206yaq.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Andrew Gaydenko wrote:
> > /* #undef CONFIG_OLD_REMAP_PAGE_RANGE */
>
> Well then configure script couldn't detect it.
> Please try the attached patch.

Without the patch, config.log says:

configure:6138: checking for new remap_page_range
configure:6167: gcc -c -g -O2 -I/lib/modules/2.4.26/build/include   conftest.c >&5
configure: In function `main':
configure:6174: warning: assignment from incompatible pointer type
configure:6170: $? = 0
configure:6173: test -s conftest.o
configure:6176: $? = 0
configure:6178: result: "yes"

And the other similar checks have the same problem.  Perhaps it would
be better to use -Werror for these tests?


Clemens




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
