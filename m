From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: CS4281 fixes (2nd try) (fwd)
Date: Tue, 20 Aug 2002 14:39:13 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0208201421520.20196-100000@aino.wakkanet.fi>
References: <s5hptwdsw3b.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from vaino.wakkanet.fi (vaino.wakkanet.fi [212.83.117.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA08380
	for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2002 14:00:04 +0200
In-Reply-To: <s5hptwdsw3b.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 20 Aug 2002, Takashi Iwai wrote:

> Kai Vehmanen wrote:
>> After doing a cvs update and recompiling and reinstalling the driver
>> package, snd-cs4281 now freezes my ibm-x20 laptop (rh7x, kernel 2.4.16,
>> today's ALSA-CVS). 0.9.0rc1 works fine. Anyone with similar experience? I
> Jaroslav already fixed this on cvs (hopefully :)
> please give a try.

Yup, works fine now (tested two laptops; one x20 and one x21)! Thanks!

>> And another cs4281 mystery: with 0.9.0rc1 the record wakeup is constantly
>> late. Even though I've set avail_min to x frames, upon wake-up there's
>> continuously more than y*x frames available (ie. not just a few samples).
> this issue is not investigated yet.  i'll get a card and take a look
> later, too.

Hmm, the very latest CVS-tree seems to work differently (rc1 -> rc3). Now
that post-rc3 snd-cs4281 works with my laptops, I'll try to reproduce the
problem.

BTW; The cs4281 compilation problem I reported earlier is definitely
     a compiler issue. On two different laptops (x20&x21 thinkpads),
     compiling with the RH72 gcc 2.96 produces a snd-cs4281.o that fails 
     to recognize the soundchip. By adding one "(volatile*)" (that shouldn't 
     have any effect), driver works on all laptops. This happens with
     current CVS and all 0.9.x release candidates. So beware 
     of that gcc version.

--
 http://www.eca.cx
 Audio software for Linux!




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
