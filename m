From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: Re: should i be able to abort in the middle of
 snd_pcm_mmap_{begin,commit} ?
Date: Tue, 19 Feb 2002 04:04:55 +0200 (EET)
Message-ID: <Pine.LNX.4.44.0202190354560.3739-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.44.0202141523230.3739-100000@ecabase.localdomain>
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

I think we can close this problem at least for now. The cause for the
garbled audio problem was found from JACK's side.

I'm still a bit puzzled why I didn't get xruns in the test case quoted
below, but until I can reproduce the problem, there's not much to discuss
about. But for the readers of alsa-devel archives, if you are having xrun
detection problems with ALSA mmap pcm API, do post a message about it. :)

On Thu, 14 Feb 2002, Kai Vehmanen wrote:

> - no xruns are detected even though after the timeout
>   alsa_driver_wait() took 56.4msec which is more than
>   period_size * number_of_periods (1024*2/44100*1000=46msec);
>   in other words there should have been an xrun

-- 
 http://www.eca.cx
 Audio software for Linux!


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
