From: fab <fab@gnux.info>
Subject: Re: ALC880 on medion laptop
Date: Sun, 26 Jun 2005 18:35:35 +0200
Message-ID: <20050626163534.GA32170@blackmilk.localzone.fr>
References: <20050626162629.GA23335@blackmilk.localzone.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050626162629.GA23335@blackmilk.localzone.fr>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: fab <fab@gnux.info>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 26/06/05 18:26 +0200, fab wrote:
> Hi,
> After the recent success-story with the alsa-cvs drivers (now the sound
> is OK for playing and the output speakers are ok) I decided to do some
> more tests. Good news:
> for playing, everything is ok, the mixer entries correspond to the
> output jacks and the internal speakers are muted automatically when I
> plug a jack on headphone or Front. This is the best behavihour IMHO.
> One remark : I have a "LFE" (??) output on the alsa-mixer and I don't
> know wtf... (I havn't a corresponding jack).
> I must note that I havn't tested the IEC958 output since I have no
> compatible device to plug.
> 
> Now the bad news:
> Recording is completly out of order :(
> The laptop owns 2 inputs: mic & line in (labeled audio in)
> The mixer gives me 6 controls for recording:
> In capture:
> Capture, Capture 1, Capture 2
> 
> In playback:
> Input source, Input source 1, Input source 2
> which are multi-choice over Mic, Front Mic, Line, CD
> 
> I can't get any sound from line in, from mic I can see a concordance
> between the recorded sound and my voice but it's rather strange.
> [recorded sample file joined]
> The sound is *very* noisy and when I speek I can hear a louder noise,
> nothing more.
> 
> Is it a known problem ?
> I hope solutions will be found as for playback, previous results are
> very encouraging.
> 
> Thanks all.
> 
> Fabien Devaux

Oups, the sample recording is here:
http://fab.gnux.info/divers/rec.ogg


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
