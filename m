From: Jean-Marc Valin <jean-marc.valin@usherbrooke.ca>
Subject: Re: Quality resampling code for libasound
Date: Tue, 20 Feb 2007 22:54:48 +1100
Message-ID: <45DAE188.6010405@usherbrooke.ca>
References: <45D92131.50601@usherbrooke.ca>	<s5hirdy72ue.wl%tiwai@suse.de>	<45D99DF7.90204@usherbrooke.ca>	<s5hhcti70pa.wl%tiwai@suse.de>	<45D9A848.9040803@usherbrooke.ca>	<s5h7iue6yyi.wl%tiwai@suse.de>	<45DA8CD2.1040606@usherbrooke.ca>
	<s5hps85rtsr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hps85rtsr.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> One concern in your code is that you use the same function names as in
> speex.  This may result in namespace conflictions if alsa-lib is used
> together with speex.  Please eitehr make these functions static and
> include from the main code, or rename functions with another prefix
> (e.g. snd_) to avoid confliction.

Right, I hadn't considered that yet. I think I prefer the static
solution -- unless you're happy with linking directly with libspeex,
which could be interesting if you're want to use the echo canceller and
noise suppressor at some point.

> That's one part making alsa-lib rate plugin so complicated.
> Anyways, the resampling algorithm plugin doesn't take care much about
> it, so far.

Are you telling me people use the high-quality sinc in libsamplerate
just to have the plugin drop samples once in a while? Can we just have a
resampler that actually produces valid output once and for all? I guess
it's another good reason to go directly with a non-plugin resampler.

BTW, the way my resampler works is that you tell it the size of the
input and output buffer and it tells you how many samples were read and
how many were written (at least one of which is the same as the buffer
size you passed). This should be flexible enough to put it in libasound
without too much complications...

	Jean-Marc

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
