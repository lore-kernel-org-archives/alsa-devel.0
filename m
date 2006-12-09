From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: alsa-lib bloat.
Date: Sat, 09 Dec 2006 14:38:35 +0000
Message-ID: <1165675115.19641.25.camel@localhost.localdomain>
References: <45795C6D.9030100@superbug.co.uk>
	<Pine.LNX.4.61.0612090908570.13335@tm8103.perex-int.cz>
	<457A995E.6080708@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <457A995E.6080708@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@lists.sourceforge.net, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

Fwiw, I've done some alsa-lib builds (no debug) for ARM with the
following results :-

Default config

-rwxr-xr-x 1 liam liam 948879 Dec  7 16:40 libasound.so.2.0.0


--disable-aload --disable-rawmidi --disable-pcm --disable-hwdep
--disable-seq --disable-instr --disable-alisp --with-pcm-plugins=hw

-rwxr-xr-x 1 liam liam 256320 Dec  9 12:39 libasound.so.2.0.0


--disable-mixer --disable-aload --disable-rawmidi --disable-pcm 
--disable-hwdep --disable-seq --disable-instr --disable-alisp
--with-pcm-plugins=hw

-rwxr-xr-x 1 liam liam 190884 Dec  9 13:08 libasound.so.2.0.0

This final configurations objects can be broken down as follows:-

645 Dec  9 13:59 ./src/compat/.libs/empty.o
2384 Dec  9 13:59 ./src/control/.libs/cards.o
5008 Dec  9 13:59 ./src/control/.libs/control_ext.o
9448 Dec  9 13:59 ./src/control/.libs/control_hw.o
57864 Dec  9 13:59 ./src/control/.libs/control.o
10712 Dec  9 13:59 ./src/control/.libs/control_shm.o
655 Dec  9 13:59 ./src/control/.libs/control_symbols.o
19456 Dec  9 13:59 ./src/control/.libs/hcontrol.o
13144 Dec  9 13:59 ./src/control/.libs/setup.o
3864 Dec  9 13:59 ./src/.libs/async.o
19468 Dec  9 13:59 ./src/.libs/confmisc.o
49540 Dec  9 13:59 ./src/.libs/conf.o
2864 Dec  9 13:59 ./src/.libs/dlmisc.o
3000 Dec  9 13:59 ./src/.libs/error.o
4324 Dec  9 13:59 ./src/.libs/input.o
3608 Dec  9 13:59 ./src/.libs/names.o
4536 Dec  9 13:59 ./src/.libs/output.o
1668 Dec  9 13:59 ./src/.libs/shmarea.o
2768 Dec  9 13:59 ./src/.libs/socket.o
1436 Dec  9 13:59 ./src/.libs/userfile.o

It looks like some further size reduction can probably be achieved by
disabling or reducing features in the conf code for embedded devices as
most only have a single sound card with only one stereo pcm for playback
and capture. 

Liam



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
