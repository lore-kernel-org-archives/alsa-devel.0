From: Jochem van der Vorm <jochem@kvz633.kvz.tudelft.nl>
Subject: HDSP9652 Matrix problem (no sound output)
Date: Thu, 12 Jun 2003 15:38:06 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030612133805.GB29736@kvz633.kvz.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hello,

Today we tried to get output sound from a Hammerfall HDSP 9652
pci-card, but were unable to hear any output. We already have a
working Hammerfall 9652 (previous version) card.

Loading the kernel modules gave no problems (?) with
alsa-driver-0.9.4.

cat /proc/asound/cards
0 [15             ]: RME9652 - RME Digi9652 (Rev 1.5)
                     RME Digi9652 (Rev 1.5) at 0xd7000000, irq 11
1 [               ]: H-DSP - Hammerfall DSP
                     RME HDSP 9652 at
		     0xd8020000, irq 5

Also clock syncing (internal and external) seems to work. If we run
brutefir and look in /proc/asound/card1/pcm0p/sub0/status:

state: RUNNING
trigger_time: 1055421299.353077000
tstamp      : 1055421314.005505000
delay       : 16384
avail       : 0
avail_max   : 8192
-----
hw_ptr      : 696320
appl_ptr    : 712704

We found out that the volumes of the channels should be set, which
we did.
    
    amixer -c1 cset name=Chn,index=$i 32768

So everything seems fine, but we still do not get output.

According to the comment from Thomas Charbonnel at the alsa details
page, we have to set a matrix between the physical and output
channels. Our preferred setup is very simple, each software output
to its according physical output (like our old Hammerfall card).

It was difficult to find more information about the matrix, we tried
various things, like amixer -c1 cset numid 5 26,0,32768 but this
all didn't help. Amixer just returns 0,0,0 ? 

Are we doing something wrong, is there more documentation about this
or does this simply not work yet
(http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg07731.html).

Any clue would be greatly appreciated,

Jochem and Rik.


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
