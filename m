From: Mathias Friman <mathias.friman@knorca.se>
Subject: Problems with hda-intel driver
Date: Tue, 19 Dec 2006 23:12:14 +0100
Message-ID: <1166566334.2082.15.camel@knc-se-lap0001.knorca.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi list.

A friend of mine has an Acer 5100 Laptop which
has a hda-intel driver sound card. He cannot start
alsamixer, it errors out with:

alsamixer: function snd_mixer_load failed: Invalid argument

When the alsa-packages are reinstalled in Kubuntu, the
alsamixer works, but after a reboot it does not anymore.
The mic input is muted, or volume set to zero. The output
works though, but no levels can be adjusted due to the
alsamixer error.

We've tried with:

options snd_hda_intel model=acer position_fix=1

in /etc/modprobe.d/alsa-base but that does not fix the
problem. 

I haven't got enough knowledge about ALSA to take
this further, so I put my hope to you guys. Below are
some outputs that might be useful:



# cat /proc/asound/cards
 0 [SB             ]: HDA-Intel - HDA ATI SB
                      HDA ATI SB at 0xd0000000 irq 209

# lspci
00:14.2 Audio device: ATI Technologies Inc Unknown device 437b (rev 01)

# amixer contents
numid=11,iface=MIXER,name='Headphone Playback Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=on,on
numid=29,iface=MIXER,name='PCM Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=255,step=0
  : values=160,160
numid=4,iface=MIXER,name='Surround Playback Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=off,off
amixer: Control default snd_hctl_elem_info error: Invalid argument

# alsactl store
alsactl: get_control:149: Cannot read control info '2,0,0,Capture Volume,1': Invalid argument



Hope this pins down the matter in some respect. :)

Regards,
Mathias


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
