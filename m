From: etienne <eyem@lalila.net>
Subject: updating 0.9.0beta3 drivers to work with cs4205
Date: Wed, 19 Jun 2002 11:29:25 +0000 (UTC)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D11BD2B.6030609@lalila.net>
Reply-To: eyem@lalila.net
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I'm trying to get jmax running on a Dell Inspiron 8200 (P4)........ 
which has a  CS 4205 chip on it.

jmax only runs with alsa 0.9.0beta3........

The card-intel8x0.c code for 0.9.0beta3 only supports Intel,82801AA, 
Intel,82901AB, Intel,82801BA and Intel,MX440.
Later versions of 0.9.0 also support (amongst others) ICH3 and ICH4

..... my card is ICH3 ... so I did some copy and paste of code from 
newer 0.9.0 into the beta3 version of card-intel8x0.c

I compiled and installed, and finally, my card is recognised and loaded 
........ /var/log/messages outputs:
Jun 18 21:31:12 xenakis kernel: PCI: Found IRQ 11 for device 00:1f.5
Jun 18 21:31:12 xenakis kernel: PCI: Sharing IRQ 11 with 00:1f.6
Jun 18 21:31:12 xenakis kernel: PCI: Setting latency timer of device 
00:1f.5 to 64

HOWEVER! ... when I try to run aplay I get:
ALSA lib pcm_hw.c:579:(snd_pcm_hw_open_subdevice) 
SNDRV_PCM_IOCTL_PVERSION failed: Invalid argument
aplay: main:442: audio open error: Invalid argument

So there are other things in other places that I also need to fix 
.................. does anyone know if this is going to be a tin of 
worms ? Am I in for a rediculous amount of changes ? .......... should I 
just buy a cheap PCMCIA card that is supported in alsa 0.9.0beta3, or am 
I close to getting it working ? (I've never played in driver code before 
so I'm worried I wont find a way out)

etienne



----------------------------------------------------------------------------
                   Bringing you mounds of caffeinated joy
                   >>>     http://thinkgeek.com/sf    <<<
