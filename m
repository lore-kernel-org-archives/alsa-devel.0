From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: dmix bugs. sounds very broken up.
Date: Mon, 1 Sep 2003 08:08:04 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309010807230.14319-100000@pnote.perex-int.cz>
References: <3F5299E6.7040408@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F5299E6.7040408@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 1 Sep 2003, James Courtier-Dutton wrote:

> I have found two problems with using the dmix alsa device name.
> 1) snd_pcm_hw_params_can_pause (params)  causes alsa-lib to assert!
> 
> 2) Sound is broken up.
> a) It can only function with 2 periods, why is that? Having 8 periods
> might be better, although "front" works fine with 2 periods, but "dmix"
> with 2 periods fails.
> b) Of the 2 periods, it sounds like sound is only being played from one
> of the periods, with silence for the other period.
> 
> Summary: -
> If I use device name "front", there are no problems with sound output.
> If I use device name "dmix", there are the above problems.

Show me your code, please (compilable example).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
