From: Guenther Sohler <guenther.sohler@newlogic.com>
Subject: silent midi in audixy
Date: Thu, 21 Feb 2002 07:51:56 +0100 (MET)
Message-ID: <XFMail.20020221075156.guenther.sohler@newlogic.com>
Reply-To: Guenther Sohler <guenther.sohler@newlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Received: from enterprise2.newlogic.com (enterprise2.newlogic.at [194.208.88.1])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id HAA01853
	for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2002 07:52:30 +0100
Received: from enterprise2.newlogic.com (enterprise2 [172.27.1.1])
	by enterprise2.newlogic.com (8.9.2/8.9.2) with ESMTP id HAA28743
	for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2002 07:51:58 +0100 (MET)
In-Reply-To: <Pine.LNX.4.31.0202200818200.529-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hallo Jaroslaw,

Yesterday I tried to load the soundfonts to load louder.
100% instead of 70% does not make much difference.
Then I tried to amplify the samples itself.
After some time i knew how to do this. But I realized, that the samples have
already been in the range from -32768 to 32767(optimal range, quality). so
amplication does not really make sence.
But i nevertheless tried to amplify and cut them, so the sf2 file was full of
square wave fonts. it sounded a little bit loader(still not enough) but the
quality was gone.
The problem in my silent music must be somewhere
As i want to play pcm and midi simultaniously in my application,
they should have approximatly have the same volume.
even i put music slider to maximum and pcm to minimum, i hardly reach this goal.

Again this question: I assume, there is an ac97 at the very output of the
audixy.  So where is the wavetable synthesizer connected to this ac97 ?
is there a block diagram available somewhere ?

Writing a small mixer dum program, i found out there are 32*3 hidden mixer
sliders with emu10k1 which amixer and alsamixer do not show, because they are
inactive.
What are they used for and how to they become active ? Are they related to my
problem ?

rds guenther


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
