From: Bo Forslund <bo.forslund@abc.se>
Subject: unresolved symbols
Date: Fri, 28 Jun 2002 19:28:43 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D1C9CCB.57D4B3AF@abc.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!


I am trying get the Linux box to talk to an external MIDI synth
connected to a SoundBlaster Live 5.1 card.... so i tried to install the
alsa driver. The kernel is 2.4.18.

Tying to load the driver gives lots of unresolved symbols. I tried
versions 0.5.12a, 0.9.0rc1 and rc2 with the same result. I started to
check this out because i have some programming ideas and eventually to
join some project.

Is it possible to send something from the computer that makes noise on
the keyboard?

Is it possible to have the computer capture what's being played on the
synth?

If external MIDI doesn't work with SB Live, does it work with some other
sound card?

Shall i forget about connecting a Linux box to a MIDI synth and install
DOS?





Here is what i have done.

    tar xjvf alsa-driver-0.9.0rc2.tar.bz2
    tar xjvf alsa-lib-0.9.0rc2.tar.bz2
    tar xjvf alsa-oss-0.9.0rc1.tar.bz2
    tar xjvf alsa-tools-0.9.0rc1.tar.bz2
    tar xjvf alsa-utils-0.9.0rc2.tar.bz2

cd alsa-driver-0.9.0rc2
    ./cvscompile  --with-sequencer=yes --with-oss=yes  --with-isapnp=no
--with-cards=emu10k1,virmidi  --with-smp=yes
    make install

cd alsa-lib-0.9.0rc2/
    ./cvscompile
    make install

.... etc  ....

cd alsa-utils-0.9.0rc2
    .cvscompile
    make install


and inserting the module gives lots of lines like this.

insmod  snd-emu10k1.o
snd-emu10k1.o: unresolved symbol snd_ctl_remove_Rsmp_5daf11ea
snd-emu10k1.o: unresolved symbol snd_verbose_printk_Rsmp_49d4e4d1
snd-emu10k1.o: unresolved symbol
snd_pcm_hw_constraint_minmax_Rsmp_74cec7bb




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Caffeinated soap. No kidding.
http://thinkgeek.com/sf
