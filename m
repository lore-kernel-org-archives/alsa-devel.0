From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_writei vs snd_pcm_mmap_writei
Date: Mon, 18 Apr 2005 11:54:10 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0504181146030.10408-100000@studcom.urz.uni-halle.de>
References: <1113817216.4263808022931@mail.e4a.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1113817216.4263808022931@mail.e4a.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dino <dino@e4a.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dino wrote:
>   these functions are similar : snd_pcm_writei and snd_pcm_mmap_writei
> but witch is the best or witch is fastest?

Using mmap access can speed up some programs that are able to
construct generate their audio data directly in the output buffer,
because copying from the application's buffer to the sound card buffer
can be avoided.  This hypothetical speed advantage is nullified when
using snd_pcm_mmap_writei because this function copies the buffer,
too.

Using snd_pcm_mmap_writei makes sense only when you do have an mmapped
device but want to copy some data from elsewhere anyway.


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
