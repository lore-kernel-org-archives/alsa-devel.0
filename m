From: matt yee-king <yeeking@no-future.com>
Subject: Re: modprobe of snd-powermac fails
Date: 26 Apr 2002 14:40:35 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1019832041.744.7.camel@bennyhill.belmont>
References: <1019828111.786.24.camel@bennyhill.belmont>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1019828111.786.24.camel@bennyhill.belmont>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

oops i spoke too soon.

the modules are loaded ok but they don't work:

# lsmod
_________________

Module                  Size  Used by    Not tainted
snd-powermac           24752   0 
snd-pcm                63680   0  [snd-powermac]
snd-timer              12768   0  [snd-pcm]
snd                    34748   0  [snd-powermac snd-pcm snd-timer]
soundcore               4744   0  [snd]
serial                 51784   0  (autoclean) (unused)
__________________

# alsaplayer auntyplexer.mp3 
alsaplayer: pcm.c:5655: snd_pcm_unlink_ptr: Assertion `0' failed.
AlsaPlayer interrupted by signal 6

# alsaplayer shackup.wav     
alsaplayer: pcm.c:5655: snd_pcm_unlink_ptr: Assertion `0' failed.
AlsaPlayer interrupted by signal 6

i tried some oss apps as well (pd, spiralsynthmodular). they don't
produce any errors, but theres no sound. 

and alsamixer has strange behaviour. the 'master' channel changes from a
mutable out channel to a 'captur' channel after a while ??

- matthew
