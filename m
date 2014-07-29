From: "Patrick Shirkey" <pshirkey@boosthardware.com>
Subject: Re: Testing/Debugging alc668 with ASUS N750JK
Date: Tue, 29 Jul 2014 14:46:23 +1000 (EST)
Message-ID: <57315.86.107.254.57.1406609183.squirrel@boosthardware.com>
References: <cover.1406259578.git.nicoleotsuka@gmail.com>
 <f4ff79269a1680f9ce128e0e98fea926d3a41834.1406259578.git.nicoleotsuka@gmail.com>
 <53D1DC0B.1000905@gmail.com>
 <63638.86.107.254.57.1406266836.squirrel@boosthardware.com>
 <CAN8cciboNrRRFBQjX66qud7KoTCqsDHxvFAws9-ywasjemtYbQ@mail.gmail.com>
 <59187.86.107.254.57.1406362728.squirrel@boosthardware.com>
 <CAN8cciax7RreogV0otMdLt0y-dOTrZD3D_ih0doAC9F_XkJ1ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from boosthardware.localdomain (boosthardware.com [88.198.122.139])
 by alsa0.perex.cz (Postfix) with ESMTP id A45C62651F0
 for <alsa-devel@alsa-project.org>; Tue, 29 Jul 2014 06:46:25 +0200 (CEST)
In-Reply-To: <CAN8cciax7RreogV0otMdLt0y-dOTrZD3D_ih0doAC9F_XkJ1ew@mail.gmail.com>
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


On Tue, July 29, 2014 1:58 pm, Raymond Yau wrote:
>> >>
>> >> What is the best way to test/debug the alc668 driver these days?
>> >>
>> >> I am running kernel 3.14.1 (debian testing/sid).
>> >>
>> >> The laptop is an ASUS N750JK.
>> >>
>> >> Sound works for front left/right speakers but the back speakers and
>> >> external lfe channel is not working on this laptop.
>> >
>> > You have to post output of alsa-info.sh
>> >
>>
>> http://boosthardware.com/alsa-info-alc668-n750jk.txt
>
> Seem BIOS only set up the front speakers
>

There is nothing in the bios to configure the audio device


>> >
>> > How many audio jacks ?
>> >
>>
>> Standard headphone/mic + yellow external lfe (sonic master). There is
>> also
>> hdmi but I am not testing that at the moment.
>
> http://www.asus.com/Notebooks_Ultrabooks/N750JK/specifications/
>
> Do you mean headset ?
>

There are the following jacks:

1 x headphone
1 x mic(line in)
1 x sonic master (yellow)
1 x hdmi (intel Haswell hdmi)


>>
>> > Do it support headset or headphone ?
>> >
>> > Do you mean there are four internal speakers ?
>> >
>>
>> There are two front speakers which produce sound through the front
>> bottom
>> of the case. There are also two back speakers which do not produce sound
>> in my tests so far.
>>
>> > Do it support surround40 in windows ?
>> >
>>
>> I am not running windows OS on this machine but I suspect it does.
>>
>> > The external sonic master and headphone need two volume controls but
>> > alc668 only have three
>> >
>> > The best way to test is using latest git version and hda jack retask
>> to
>> >
>>
>> The process has changed somewhat since I last did this.
>>
>
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/log/sound/pci/hda?qt=grep&q=alc668
>

That suggest not much has changed for a while?


>>
>> > 1) four internal speaker and headphone
>> > 2) two internal speaker, headphone and external subwoofer
>> >
>> > Once you confirm the nodes of the speakers, subwooder
>> > You need to decide whether headphone share the volume controls with
>> the
>> > speaker/subwoofer
>> >>
>>
>> I have spent some time on this step already with 3.14.1
>
> Did you retask the node of subwoofer as speaker or line out ?
>

I have tried both but I have not been able to identify the subwoofer.

I have tried playing with: 16, 19, 1a

> For multi channel, the sequence number is ascending and the driver expect
> they have same type i.e, all speakers or all line out jacks
>
> Did you find the node of the rear speakers in  (1) ?
>

I have not found them yet.

> Did surround 4.0 work when you fix the rear speaker ?
>

Only the front speakers play audio but they don't work with 4.0 enabled

> Did you find the node of the external subwoofer  in (2) ?
>

Not yet.

> Did the sonic master subwoofer detected   ?
> hda jack sense test -a
>

I have grabbed the scripts but I get this error when running hda-analyzer:

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


> Do the subwoofer only use right channel ?
>

I cannot hear the subwoofer at this point

> Do surround 2.1 works ?
>

It says it is working but I do not get sound out of the sub woofer.  I can
hear static(whitenoise) through the front speakers (with pulseaudio test)
if  I set pins 0x19 and 0x1a to Line Out (Center/LFE) and Internal
(Center/LFE) or vice versa with hdajackretask.

>>
>> Is there a specific reason this process is not already scripted other
>> than
>> no one has taken the time to do it?
>
> Do surround 4.1 or 5.1 work when you fix both speaker and subwoofer ?
>

Surround 4.1/5/1 do not produce any sound from my tests so far (using PA
Test)

> Do  you prefer driver create  headphone volume control or subwoofer volume
> control ?
>

I would like the lfe to be sent through the yellow sonic master jack. I am
not concerned with the headset jack at the moment. A cursory test shows
just the right channel is working on the headset jack.


>>
>> Can we not create a test script that will run through all the logical
>> combinations and provide all the relevant info?
>>
>
> The driver hardcore the name of volume control to bass when there are two
> speaker nodes for those 2.1
>

I do not see any controls for the bass volume in alsamixer




>>
>> >> - I have found a couple of kernel bug reports  for other ASUS models
>> >> with
>> >> this chipset but they are both marked resolved. Should I open a new
>> >> ticket
>> >> ?
>> >>
>> >> https://bugzilla.kernel.org/show_bug.cgi?id=65091
>> >> https://bugzilla.kernel.org/show_bug.cgi?id=66271
>> >>
>> >> - I can hear static through the front speakers (with pulseaudio test)
>> >> if
>> >> I set pins 0x19 and 0x1a to Line Out (Center/LFE) and Internal
>> >> (Center/LFE) or vice versa with hdajackretask.
>> >>
>> >> Pin 0x16 does not appear to work at all.
>> >>
>> >> I see this output when I apply the config in hdajackretask.
>> >>
>> >> 0x12 0x90a60140
>> >> 0x14 0x99130110
>> >> 0x15 0x04211020
>> >> 0x16 0x99134111
>> >> 0x18 0x01a19840
>> >> 0x19 0x01014011
>> >> 0x1a 0x411111f0
>> >> 0x1b 0x411111f0
>> >> 0x1d 0x40c6852d
>> >> 0x1e 0x014b1180
>> >> 0x1f 0x411111f0
>> >> 1
>> >>
>


--
Patrick Shirkey
Boost Hardware Ltd
