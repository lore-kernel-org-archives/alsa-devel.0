From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: should i be able to abort in the middle of
 snd_pcm_mmap_{begin,commit} ?
Date: Thu, 14 Feb 2002 15:01:07 +0200 (EET)
Message-ID: <Pine.LNX.4.44.0202132025530.11029-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <200202131815.NAA15651@renoir.op.net>
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

On Wed, 13 Feb 2002, Paul Davis wrote:

[xrun after mmap_begin]
> after restarting, the audio stream is not in sync - it contains minor
> crackles and clicks suggesting that the device driver doesn't really
> know where the hw pointer is. the effect varies with the period size,
> which reinforces my belief in what's gone wrong. this happens on both
> the hammerfall and the trident, though the effect sounds a little

I've noticed similar problems with CVS versions of ALSA and JACK. My
card is ens1371. The crackled audio doesn't occur every time, but 
practically always after a subgraph timeouts. The sound is mostly ok 
(stereo image is fine, rate is correct, also amplitude), but it's 
badly garbled (for lack of a better adjective).

Hmm, it could be that committed periods overlap in hw mem, or are shorter
than longer than what hw excepts (-> gaps between committed periods). 

-- 
 http://www.eca.cx
 Audio software for Linux!


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
