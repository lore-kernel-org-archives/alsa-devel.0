From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: cvs build help
Date: Mon, 01 Sep 2003 10:48:30 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0309011048110.6124-100000@studcom.urz.uni-halle.de>
References: <200308311734.h7VHY1612936@cichlid.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200308311734.h7VHY1612936@cichlid.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrew Burgess <aab@cichlid.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Andrew Burgess wrote:
> How do I get rid of the "-I/lib/modules/2.4.22-pre6/build/include" in the CFLAGS
> when building cvs? My kernel is 2.4.23-pre2
>
> I did:
>
>  build prep
>  build config
>  build clean
>  build all
>
> and still it insists on 2.4.22-pre6

make cvsclean


HTH
Clemens




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
