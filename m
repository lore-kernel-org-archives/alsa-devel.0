From: Daniel MacDonald <danboid@yahoo.co.uk>
Subject: BUG REPORT: NFORCE2/Soundstorm recording broke
Date: Sat, 4 Oct 2003 02:52:39 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031004095239.3516.qmail@web86304.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

My setup is:

ALSA driver 0.9.7a, 0.9.7 lib
Linux kernel 2.4.21
RedHat 9
ASUS A7N8X Deluxe/ NFORCE2 chipset with Soundstorm
onboard sound

Playback of both PCM and MIDI sound works fine but the
problem is that recording doesn't work under ALSA.
When I type 'arecord -l' I get this:

**** List of CAPTURE Hardware Devices ****
card 0: nForce2 [NVidia nForce2], device 0: Intel ICH
[NVidia nForce2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

but the when I issue 'arecord -t wav -f cd -d 6
test.wav' I just get a silent test.wav file. I've
tried recording under Audacity too and that produces
similiar results, unless I use the OSS kernel driver
and then I can record in 16-bit, 44.1khz stereo but
not mono and no full-duplex either.

The funny thing is that full duplex recording under
ALSA did actually work under Audacity with my same
hardware setup- this was when I was running Mandrake
9.1 and an earlier ALSA version (0.9.2 or
thereabouts), so I know it is possible.

I've reported this bug to this list before but either
it just got ignored or there are no ALSA developers
who own a NFORCE2 board. If this isn't the right place
to report such bugs I would appreciate if someone
forwarded this to the right address or told me where
to send it.

Thanks,

dan

http://www.transelement.co.uk

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
