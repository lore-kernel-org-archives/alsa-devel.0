From: alfonso_acosta_mail@yahoo.es
Subject: unresolved symbol: snd_pci_hack_alloc_consistent_R94f2775
Date: Mon, 21 Apr 2003 21:16:05 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EA44375.3070902@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi:

After downloading last CVS version of alsa-driver with:

cvscompile CC=gcc --prefix=/usr --with-kernel=/usr/src/linux 
--with-moddir=/lib/modules/2.4.20/alsa --with-sequencer=yes 
--with-isapnp=no --with-debug=detect --with-cards="emu10k1"

I get this error when trying to "modprobe snd-emu10k1":

/lib/modules/2.4.20/alsa/snd-page-alloc.o: unresolved symbol 
snd_pci_hack_alloc_consistent_R94f27756
/lib/modules/2.4.20/alsa/snd-page-alloc.o: insmod 
/lib/modules/2.4.20/alsa/snd-page-alloc.o failed
/lib/modules/2.4.20/alsa/snd-page-alloc.o: insmod snd-emu10k1 failed

What am I doing wrong?

(I need the cvs version to test echoaudio driver, so using version 0.9.2 
isn a solution)

Thanks in advance

Alfonso Acosta



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
