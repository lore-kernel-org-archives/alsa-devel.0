From: "Bill Adair" <adair@gotadsl.co.uk>
Subject: Device references for MIDI sub-devices
Date: Thu, 24 Feb 2005 10:09:07 -0000
Message-ID: <opsmo45hdan0kn27@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: alsa-devel-admin@lists.sourceforge.net
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

I'm nearly at the end of the development of my serial port driver for the=
 =20
Opcode 64X and
am testing it with various applications. My current problem / question is=
 =20
- How do I
refer to the different sub-devices shown below?

linux:/home/billa # aconnect -lo
client 72: 'uart16550 MIDI #0' [type=3Dkernel]
     0 'uart16550 MIDI #0-0'
     1 'uart16550 MIDI #0-1'
     2 'uart16550 MIDI #0-2'
     3 'uart16550 MIDI #0-3'
linux:/home/billa # amidi -l
Device    Name
hw:1,0    uart16550 MIDI #0 (4 subdevices)

Rosegarden can see them and speak to each but JSynthLib will only make =20
contact
with /dev/snd/midiC1D0 which is 0 'uart16550 MIDI #0-0' or the first =20
output port
on the device. Are there ways of refering to the other ports using =20
/dev/snd/XXXXXX?

Bill



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
