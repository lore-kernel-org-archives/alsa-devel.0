From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: CS4281 fixes (2nd try)
Date: Tue, 20 Aug 2002 15:43:26 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0208201542270.20550-100000@aino.wakkanet.fi>
References: <Pine.LNX.4.44.0208201421520.20196-100000@aino.wakkanet.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from vaino.wakkanet.fi (vaino.wakkanet.fi [212.83.117.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA09307
	for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2002 15:04:13 +0200
In-Reply-To: <Pine.LNX.4.44.0208201421520.20196-100000@aino.wakkanet.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 20 Aug 2002, Kai Vehmanen wrote:

> BTW; The cs4281 compilation problem I reported earlier is definitely
>      a compiler issue. On two different laptops (x20&x21 thinkpads),
>      compiling with the RH72 gcc 2.96 produces a snd-cs4281.o that fails 
>      to recognize the soundchip. By adding one "(volatile*)" (that shouldn't 
>      have any effect), driver works on all laptops. This happens with
>      current CVS and all 0.9.x release candidates. So beware 
>      of that gcc version.

Same happens with gcc 2.96-110 that comes with RH73.

--
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
