From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_writei vs snd_pcm_mmap_writei
Date: Mon, 18 Apr 2005 14:08:19 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0504181406110.5619-100000@studcom.urz.uni-halle.de>
References: <1113818692.4263864449a32@mail.e4a.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1113818692.4263864449a32@mail.e4a.it>
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
> So i have to use the pairs: snd_pcm_mmap_begin snd_pcm_mmap_commit to make use
> of a "real" mmap pcm, instead of snd_pcm_mmap_writei?

Yes.  snd_pcm_mmap_writei just calls the _begin/_commit functions
before/after copying the buffer.  If you call them yourself, you can
do something else instead of simple copying.


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
