From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: How to get information for a busy device?
Date: Mon, 12 Aug 2002 21:33:03 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0208122129590.1463-100000@pnote.perex-int.cz>
References: <200208121823.g7CINs724461@d1o1116.telia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA07672
	for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2002 21:37:13 +0200
In-Reply-To: <200208121823.g7CINs724461@d1o1116.telia.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Anders Torger <torger@ludd.luth.se>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 12 Aug 2002, Anders Torger wrote:

> I'd like to be able to get the minimum period size for a pcm device, so 
> then I use snd_pcm_hw_params_get_period_size_min(), however, that (of 
> course) needs a pcm as the first argument.
> 
> In my application it would be good if it was possible to get this 
> information, even if the device in question is busy or temporarily 
> cannot be accessed by some other reason, causing snd_pcm_open to fail.
> 
> Is this possible to do in some way?

Nope. This information is dynamic at runtime (might depend on the 
state of other parts of hardware).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
