From: Gerhard Dirschl <gerhard.dirschl@gmx.de>
Subject: Re: devfs trouble in latest cvs
Date: Fri, 9 May 2003 22:20:05 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030509202005.GA1244@euh11a303.stud.uni-karlsruhe.de>
References: <20030509181245.GA1617@euh11a303.stud.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030509181245.GA1617@euh11a303.stud.uni-karlsruhe.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, May 09, 2003 at 08:12:45PM +0200, Gerhard Dirschl wrote:
> The one in wrappers.c crashes my machine on driver unloading, the one in
> misc.c works fine.

snd_compat_devfs_remove() in acore/wrappers.c still produces an Oops 
May  9 22:02:54 localhost kernel: devfs_put(df1a5c20): poisoned pointer
May  9 22:02:54 localhost kernel: Forcing Oops
May  9 22:02:54 localhost kernel: kernel BUG at base.c:914!
May  9 22:02:54 localhost kernel: invalid operand: 0000
May  9 22:02:54 localhost kernel: CPU:    0
May  9 22:02:54 localhost kernel: EIP:    0010:[<c0170564>]    Not tainted
May  9 22:02:54 localhost kernel: EFLAGS: 00010282
...

Apply this to fix it
@@ -51,7 +51,6 @@
        if (n < 64 && buf[0]) {
                devfs_handle_t de = devfs_find_handle(NULL, buf, 0, 0, 0, 0);
                devfs_unregister(de);
-               devfs_put(de);
        }
 }

(or keep devfs_put(de) and replace devfs_find_handle with devfs_get_handle)

  ciao
    Gerhard

-- 
Gerhard Dirschl
Karlsruhe
Germany


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
