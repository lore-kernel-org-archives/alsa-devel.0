From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: CS4281 fixes (2nd try) (fwd)
Date: Wed, 21 Aug 2002 15:01:45 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0208211439240.31249-100000@aino.wakkanet.fi>
References: <4EFAB02CD1631648856752B7E482C9A312CA45@esebe003.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from vaino.wakkanet.fi (vaino.wakkanet.fi [212.83.117.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA28998
	for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2002 14:22:37 +0200
In-Reply-To: <4EFAB02CD1631648856752B7E482C9A312CA45@esebe003.ntc.nokia.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>> BTW; The cs4281 compilation problem I reported earlier is definitely
>>      a compiler issue. On two different laptops (x20&x21 thinkpads),
>>      compiling with the RH72 gcc 2.96 produces a snd-cs4281.o that fails 
>>      to recognize the soundchip. By adding one "(volatile*)" (that shouldn't 
> the attached patch works for you?

Unfortunately no. To make it work, I needed to add another volatile 
keyword:

-	int ac97_num = ((volatile ac97_t *)ac97)->num;
+	volatile int ac97_num = ((volatile ac97_t *)ac97)->num;

Diff between the resulting assembly files (with gcc-2.96-100) is nearly
200 lines! Removing the second 'volatile' removes just one "movzwl %ax,
%eax" operation from the assembly output, and the driver still works. Ugh,
luckily redhat still ships kgcc (egcs-1.1.2) with RH7.3. I strongly
recommend using it to compile alsa-driver/alsa-kernel.

PS Compiling with -O instead of -O2 also produces a working driver
   with the rh73 gcc.

--
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
