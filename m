From: Peace Monk <peace.monk@gmail.com>
Subject: Simultanious spdif and analog output.
Date: Sun, 24 Oct 2004 17:06:51 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <2558a190041024170613241694@mail.gmail.com>
Reply-To: Peace Monk <peace.monk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I apologize for sending to the devel mailing list.  I have not
received any response from the user mailing list for many days.

I have the spdif digital out of my MAudio Revolution 7.1
card working.  What I am trying to do now is to get analog audio signal
simultaneously so I can feed it to a VCR.   What changes should I make
to the file asound.conf, so i can get audio from the analog connections as well?

I already looked at the documentation for asoundrc file, but I cant
seem to figure it out.. any help will be appreciated..  Here are my
current specs:

[root@htpc etc]# cat /etc/asound.conf
pcm.!default {
   type plug
   slave.pcm "hw:0,1"  (this is the spdif device on the sound card)
}

[root@htpc etc]# cat /proc/asound/cards
0 [Revolution71   ]: ICE1724 - M Audio Revolution-7.1
                 M Audio Revolution-7.1 at 0xe400, irq 5

[root@htpc etc]# aplay -l

**** List of PLAYBACK Hardware Devices ****
card 0: Revolution71 [M Audio Revolution-7.1], device 0: ICE1724 [ICE1724]
Subdevices: 0/1
Subdevice #0: subdevice #0
card 0: Revolution71 [M Audio Revolution-7.1], device 1: IEC1724
IEC958 [IEC1724 IEC958]
Subdevices: 1/1
Subdevice #0: subdevice #0
card 0: Revolution71 [M Audio Revolution-7.1], device 2: ICE1724
Surrounds [ICE1724 Surround PCM]
Subdevices: 3/3
Subdevice #0: subdevice #0
Subdevice #1: subdevice #1
Subdevice #2: subdevice #2


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
