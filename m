From: Jussi Laako <jussi.laako@kolumbus.fi>
Subject: Re: libasound segfault
Date: Sun, 24 Mar 2002 18:49:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3C9E039B.972F57AB@kolumbus.fi>
References: <Pine.LNX.4.33.0203131945500.511-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> 
> > >(gdb) bt
> > >#0  0x4015e8d7 in snd_pcm_route_convert1_one () from /usr/lib/libasound.so.2
> > >#1  0x40cae5dc in ?? ()
> > >#2  0x012de908 in ?? ()
> > >Error accessing memory address 0xe8c1018b: No such process.
> > >(gdb)
> 
> Can we see your code? The 32-bit format should work.

Well, I didn't remember I made 32-bit mean float's, but neither 24 nor 32
bit mode of my code works. I get alsa errors with both.

http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/hasas/HASAS/AudioA2.cc?rev=1.2&content-type=text/vnd.viewcvs-markup


	- Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
