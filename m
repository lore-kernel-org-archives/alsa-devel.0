From: "Patrick Shirkey" <pshirkey@boosthardware.com>
Subject: hda_analyzer vs alc668 asus NJ750k
Date: Tue, 29 Jul 2014 23:09:02 +1000 (EST)
Message-ID: <59001.86.107.254.57.1406639342.squirrel@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from boosthardware.localdomain (boosthardware.com [88.198.122.139])
 by alsa0.perex.cz (Postfix) with ESMTP id 988FB2650C3
 for <alsa-devel@alsa-project.org>; Tue, 29 Jul 2014 15:09:03 +0200 (CEST)
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

Hi,

I get some errors running hda_analyzer with this alc668 chipset.

Traceback (most recent call last):
  File "/dev/shm/hda-analyzer/hda_analyzer.py", line 546, in <module>
    sys.exit(main(sys.argv))
  File "/dev/shm/hda-analyzer/hda_analyzer.py", line 523, in main
    if read_nodes(sys.argv[1:]) == 0:
  File "/dev/shm/hda-analyzer/hda_analyzer.py", line 89, in read_nodes
    read_nodes2(c.card, i)
  File "/dev/shm/hda-analyzer/hda_analyzer.py", line 60, in read_nodes2
    c = HDACodec(card, codec)
  File "/dev/shm/hda-analyzer/hda_codec.py", line 1041, in __init__
    self.parse_proc()
  File "/dev/shm/hda-analyzer/hda_codec.py", line 1140, in parse_proc
    self.proc_codec = HDACodecProc(self.card, self.device, file)
  File "/dev/shm/hda-analyzer/hda_proc.py", line 479, in __init__
    self.parse(proc_file)
  File "/dev/shm/hda-analyzer/hda_proc.py", line 677, in parse
    node.add_digital(line[11:])
  File "/dev/shm/hda-analyzer/hda_proc.py", line 296, in add_digital
    self.wrongfile('unknown dig1 bit %s' % repr(b))
  File "/dev/shm/hda-analyzer/hda_proc.py", line 143, in wrongfile
    raise ValueError, "wrong proc file format (%s)" % msg
ValueError: wrong proc file format (unknown dig1 bit 'KAE')


If I disable the check for add_digital I get this error:

ValueError: wrong proc file format (  Digital: Enabled KAE)

- Is it a problem to add a new DIG1_BIT to hda_proc.py:277

 def add_digital(self, line):
    bits = {
      'Enabled': DIG1_BITS['ENABLE'],
      'Validity': DIG1_BITS['VALIDITY'],
      'ValidityCfg': DIG1_BITS['VALIDITYCFG'],
      'Preemphasis': DIG1_BITS['EMPHASIS'],
      'Copyright': DIG1_BITS['COPYRIGHT'], # old buggy format
      'Non-Copyright': DIG1_BITS['COPYRIGHT'],
      'Non-Audio': DIG1_BITS['NONAUDIO'],
      'Pro': DIG1_BITS['PROFESSIONAL'],
      'GenLevel': DIG1_BITS['LEVEL'],
      'KAE': DIG1_BITS['KAE'],
    }

hda_codec.py:224

 DIG1_BITS = {
  'ENABLE': 0,
  'VALIDITY': 1,
  'VALIDITYCFG': 2,
  'EMPHASIS': 3,
  'COPYRIGHT': 4,
  'NONAUDIO': 5,
  'PROFESSIONAL': 6,
  'LEVEL': 7,
  'KAE': 8
}


- If I do that I get this error:


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
1043, in __init__
    self.parse_proc()
  File "/home/patrick/code/alsa-utilities/hda-analyzer/hda_codec.py", line
1142, in parse_proc
    self.proc_codec = HDACodecProc(self.card, self.device, file)
  File "/home/patrick/code/alsa-utilities/hda-analyzer/hda_proc.py", line
480, in __init__
    self.parse(proc_file)
  File "/home/patrick/code/alsa-utilities/hda-analyzer/hda_proc.py", line
732, in parse
    self.wrongfile(line)
  File "/home/patrick/code/alsa-utilities/hda-analyzer/hda_proc.py", line
143, in wrongfile
    raise ValueError, "wrong proc file format (%s)" % msg
ValueError: wrong proc file format (  Devices: 0)

- If I replace the call in hda_proc.py:734 to self.wrongfile() with a
print command

ex.
        else:
           print ('strange line : %s' % line)
         # self.wrongfile(line)

I get this output and hda_analyzer interface starts:

# python hda_analyzer.py
strange line :   Devices: 0
strange line :   In-driver Connection: 3
strange line :      0x02 0x03 0x04
strange line :   Devices: 0
strange line :   In-driver Connection: 3
strange line :      0x02 0x03 0x04
strange line :   Devices: 0
strange line :   In-driver Connection: 3
strange line :      0x02 0x03 0x04


- If I run "alsa-jack-sense-test -a"  I get this output:


# python alsa-jack-sense-test.py -a
strange line :   Devices: 0
strange line :   In-driver Connection: 3
strange line :      0x02 0x03 0x04
strange line :   Devices: 0
strange line :   In-driver Connection: 3
strange line :      0x02 0x03 0x04
strange line :   Devices: 0
strange line :   In-driver Connection: 3
strange line :      0x02 0x03 0x04
Pin 0x05 (Unknown Digital Out): present = No
Pin 0x06 (Unknown Digital Out): present = No
Pin 0x07 (Unknown Digital Out): present = No


--
Patrick Shirkey
Boost Hardware Ltd
