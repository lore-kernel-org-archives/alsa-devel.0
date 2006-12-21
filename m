From: Ahmet =?utf-8?B?xLBuYW4=?= <ainan@mathematik.uni-freiburg.de>
Subject: Re: [PATCH] make snd-aloop loopback device work
Date: Thu, 21 Dec 2006 20:09:40 +0100
Message-ID: <20061221190940.GA24147@mathematik.uni-freiburg.de>
References: <20061220225811.GB705@mathematik.uni-freiburg.de>
	<s5h7iwlrvdm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h7iwlrvdm.wl%tiwai@suse.de>
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

> Thanks for the patch.  The changes look almost good to me.
it still needs some refinement but imho its very usable now.

> One of my remaining concern in this code is the case where hw_params
> are different on playback and capture sides.  Did you test that case?
yes sure and this is why i have these 2 implementations .. the first one
doesnt need to have both hw_params same. only the second, which is still
not finished (memory leak on close) and is off by default. both work
wonderfully for me.

> Anyway, Jaroslav should have some ideas about the implementation, as
> he initiated this driver...
im always open for suggestions.

ahmet


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
