From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: dB gain
Date: Mon, 29 May 2006 15:47:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0605291540430.11164@tm8103-a.perex-int.cz>
References: <4478A290.80702@superbug.co.uk> <s5hverp7zcr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6D12B150
	for <alsa-devel@alsa-project.org>;
	Mon, 29 May 2006 15:47:53 +0200 (MEST)
In-Reply-To: <s5hverp7zcr.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 29 May 2006, Takashi Iwai wrote:

> Also, a bit more sensible names are preferred for new stuff.
> "misc" sounds too ambiguous to me, and "info2" is...

Perhaps 'desc' like description or 'extra' is more appropriate.

Also, I'm not sure, if hint is the right behaviour. Probably, the better 
way is to create a new identifier and ecapsulate min, max and step values 
into 32-bit word, so we won't eat much memory and the information for 
alsa-lib will be more abstract for your case. Of course, some hardware can 
have non-continuous dB scale so special expressions must be in alsa-lib.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
