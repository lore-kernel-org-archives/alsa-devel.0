From: "Patrick Shirkey" <pshirkey@boosthardware.com>
Subject: Re: hda_analyzer vs alc668 asus NJ750k
Date: Wed, 30 Jul 2014 01:42:45 +1000 (EST)
Message-ID: <60295.86.107.254.57.1406648565.squirrel@boosthardware.com>
References: <59001.86.107.254.57.1406639342.squirrel@boosthardware.com>
 <CAN8cciZgy+OeSxpHYZXjr-dmikPeQiWJhcLPLjZrL=-9BENoZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from boosthardware.localdomain (boosthardware.com [88.198.122.139])
 by alsa0.perex.cz (Postfix) with ESMTP id D9B4E26548F
 for <alsa-devel@alsa-project.org>; Tue, 29 Jul 2014 17:42:46 +0200 (CEST)
In-Reply-To: <CAN8cciZgy+OeSxpHYZXjr-dmikPeQiWJhcLPLjZrL=-9BENoZQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Wed, July 30, 2014 1:25 am, Raymond Yau wrote:
>
> You need to specify card 1 if you want test the alc668
>
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/hda_proc.c?id=6152597971db4055b7b03ccc60afcd62214d41f4
>
> The error is because  codec.py cannot parse the output of hda_proc.c
>

I have tried a few options but the only things that allow the UI to run
are the steps above.

For example If I revert the changes and run this commandline I get the
same errors.

sudo python hda_analyzer.py /proc/asound/card1/codec#0

Traceback (most recent call last):
  File "hda_analyzer.py", line 546, in <module>
    sys.exit(main(sys.argv))
  File "hda_analyzer.py", line 523, in main
    if read_nodes(sys.argv[1:]) == 0:
  File "hda_analyzer.py", line 89, in read_nodes
    read_nodes2(c.card, i)
  File "hda_analyzer.py", line 60, in read_nodes2
    c = HDACodec(card, codec)
  File "/home/patrick/code/alsa-utilities/hda-analyzer/hda_codec.py", line
1041, in __init__
    self.parse_proc()
  File "/home/patrick/code/alsa-utilities/hda-analyzer/hda_codec.py", line
1140, in parse_proc
    self.proc_codec = HDACodecProc(self.card, self.device, file)
  File "/home/patrick/code/alsa-utilities/hda-analyzer/hda_proc.py", line
479, in __init__
    self.parse(proc_file)
  File "/home/patrick/code/alsa-utilities/hda-analyzer/hda_proc.py", line
677, in parse
    node.add_digital(line[11:])
  File "/home/patrick/code/alsa-utilities/hda-analyzer/hda_proc.py", line
296, in add_digital
    self.wrongfile('unknown dig1 bit %s' % repr(b))
  File "/home/patrick/code/alsa-utilities/hda-analyzer/hda_proc.py", line
143, in wrongfile
    raise ValueError, "wrong proc file format (%s)" % msg
ValueError: wrong proc file format (unknown dig1 bit 'KAE')


Apart from that the documentation on hda_analyzer is sparse and figuring
out what to do with the interface will require several hours of my life.

Maybe I have missed something with the alsa-jack-sense-test script or one
of the other python scripts but is it possible to script a tool that will
try out every solution and figure out which pins should be enabled or are
missing to achieve various results?




--
Patrick Shirkey
Boost Hardware Ltd
