From: jfm3 <jfm3@ouroboros-complex.org>
Subject: Re: [Alsa-user] HDSP + multiface + PCMCIA
Date: 15 May 2003 10:02:09 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1053007335.6938.0.camel@localhost.localdomain>
References: <20030514224845.80447.qmail@web13301.mail.yahoo.com>
	<Pine.OSX.4.53.0305151130510.429@silk.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.OSX.4.53.0305151130510.429@silk.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: iain@psand.net
Cc: ALSA Developer List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

At this point in my limited understanding of it, you run hdsploader and
hope for the best. Let me know if running hdsploader works for you.

Good luck!

On Thu, 2003-05-15 at 06:41, Iain Kennedy wrote:
> Hello,
> 
> I've got a PCMCIA HDSP multiface card from RME... I'm running a debian
> (testing) system, with a custom kernel, 2.4.20 with alan cox's low latency
> patches applied. I am using the built in kernel PCMCIA support, which
> works fine for the wireless network cards that I am using. I have ALSA
> 0.9.3a installed on the machine and this talks fine to the built in
> soundcard. I have disabled the internal soundcard on the board and
> configured the beasty to use snd-hdsp, following the instructions on the
> alsa website. On boot, the driver states there is no multiface connected...
> I get the following messages in my /var/log/syslog file:
> 
> 
> May 15 11:36:06 plinth kernel: Hammerfall memory allocator: buffers allocated fo
> r 1 cards
> May 15 11:36:06 plinth kernel: PCI: Setting latency timer of device 02:00.0 to 6
> 4
> May 15 11:36:06 plinth kernel: ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:508: Ha
> mmerfall-DSP: no Digiface or Multiface connected!
> May 15 11:36:06 plinth kernel: ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:4095: c
> ard initialization pending : waiting for firmware
> 
> I've changed the firmware from 10 to 11, I've checked the cable and
> box on a Mac + Windows machine and all is fine....
> 
> Here are the messages from the cardmgr:
> 
> May 15 11:36:11 plinth cardmgr[287]: starting, version is 3.1.33
> May 15 11:36:11 plinth cardmgr[287]: watching 1 sockets
> May 15 11:36:11 plinth cardmgr[287]: Card Services release does not match
> May 15 11:36:11 plinth kernel: cs: IO port probe 0x0c00-0x0cff: clean.
> May 15 11:36:11 plinth kernel: cs: IO port probe 0x0800-0x08ff: clean.
> May 15 11:36:11 plinth kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x378-
> 0x37f 0x400-0x47f 0x4d0-0x4d7
> May 15 11:36:11 plinth kernel: cs: IO port probe 0x0a00-0x0aff: clean.
> May 15 11:36:11 plinth cardmgr[287]: socket 0: CardBus hotplug device
> 
> Here is the output of lsmod:
> 
> nelf@plinth:~$ lsmod
> Module                  Size  Used by    Not tainted
> snd-seq-oss            26944   0 (unused)
> snd-seq-midi-event      3528   0 [snd-seq-oss]
> snd-seq                37296   2 [snd-seq-oss snd-seq-midi-event]
> snd-pcm-oss            37732   0 (unused)
> snd-mixer-oss          12184   0 [snd-pcm-oss]
> snd-hdsp               30412   0
> snd-rawmidi            13888   0 [snd-hdsp]
> snd-seq-device          4148   0 [snd-seq-oss snd-seq snd-rawmidi]
> snd-pcm                61440   0 [snd-pcm-oss snd-hdsp]
> snd-timer              14920   0 [snd-seq snd-pcm]
> snd-page-alloc          5248   0 [snd-pcm]
> snd-hwdep               4832   0 [snd-hdsp]
> snd                    31076   0 [snd-seq-oss snd-seq-midi-event snd-seq snd-pcm-oss snd-mixer-oss snd-hdsp snd-rawmidi snd-seq-device snd-pcm snd-timer snd-hwdep]
> soundcore               3716   3 [snd]
> snd-hammerfall-mem      1920   0 [snd-hdsp]
> iptable_filter          1612   0 (autoclean) (unused)
> ip_tables              11704   1 [iptable_filter]
> via-rhine              12432   1
> rtc                     6908   0 (autoclean)
> 
> 
> Any help would be greatly appreciated...
> 
> Technical Director, Psand Ltd.
> http://www.psand.net -- Tel: 0044 (0)7773 291256
> 
> 
> -------------------------------------------------------
> Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
> The only event dedicated to issues related to Linux enterprise solutions
> www.enterpriselinuxforum.com
> 
> _______________________________________________
> Alsa-user mailing list
> Alsa-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-user
-- 
(jfm3  2838 BCBA 93BA 3058 ED95  A42C 37DB 66D1 B43C 9FD0)



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
