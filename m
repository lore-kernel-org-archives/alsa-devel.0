From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: Re: rc4 is out
Date: Wed, 23 Oct 2002 14:00:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021023140057.6ee7b1d8.mdeboer@iua.upf.es>
References: <Pine.LNX.4.33.0210222306580.3295-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from iuamtg.upf.es (iuamtg.upf.es [193.145.55.151])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA03737
	for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2002 14:05:02 +0200
In-Reply-To: <Pine.LNX.4.33.0210222306580.3295-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I just installed alsa-driver-0.9.0rc4, but alas.... i get invalid parameter
when modprobing...

$ uname -ra
Linux bitone 2.4.18-686 #1 Sun Apr 14 11:32:47 EST 2002 i686 unknown unknown GNU/Linux

(this is the Debian 2.4.18-686 kernel)

$ tar jxvf alsa-driver-0.9.0rc4.tar.bz2

[...]

$ cd alsa-driver-0.9.0rc4
$ ./configure ; make ; make install

[...]

$ modprobe snd-emu10k1
/lib/modules/2.4.18-686/kernel/sound/acore/snd.o: invalid parameter parm_snd_major
/lib/modules/2.4.18-686/kernel/sound/acore/snd.o: insmod /lib/modules/2.4.18-686/kernel/sound/acore/snd.o failed

/lib/modules/2.4.18-686/kernel/sound/acore/snd.o: insmod snd-emu10k1 failed



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
