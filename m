From: Guenther Sohler <guenther.sohler@newlogic.com>
Subject: problems and questions with creative audixy
Date: Thu, 07 Feb 2002 17:35:37 +0100 (MET)
Message-ID: <XFMail.020207173537.guenther.sohler@newlogic.com>
Reply-To: Guenther Sohler <guenther.sohler@newlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
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

Hallo List,

I migrated to alsa now. I think its a quite good concept, but I think I have
found some bugs

When I play a midi file to the audixy wavetable synth, and there is a
instrument like a cello which sounds till you switch it off, and you interupt
with CTRL-C it stays hanging. its done with the midi port but
the the port to the audixy synth should do a  "all note off" when it is beeing
closed

With my audixy all the 4 wavetable ports are fine but the midi ports do not work
If I try to access them, there is following error message issued:
alsa ../../alsa-kernel/pci/emu10k1/emumpu401.c:126 cmd 0xff failed at
0xd400(status=0xff, data=0xff)

the same command is repeated with 0x3f isntead of 0xff after 126

There are nice external-midi devices in /dev/snd where you can put raw midi
data to, but there are no devices which go to the wavetable synth of the audixy


Where can i find a description on all the snd midi modules especially not the
pci and the isa but the general ones. snd-virmidi is just an example of a
module i dont know its meaning at all.


thankx in advance

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
