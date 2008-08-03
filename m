From: Ben Stanley <Ben.Stanley@exemail.com.au>
Subject: Re: ca0106 SPDIF Output Problems
Date: Sun, 03 Aug 2008 22:46:18 +1000
Message-ID: <1217767578.9287.115.camel@localhost>
References: <1215086952.30056.190.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.po.exetel.com.au (pecan.exetel.com.au [220.233.0.17])
	by alsa0.perex.cz (Postfix) with ESMTP id C51EE103849
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Aug 2008 14:46:23 +0200 (CEST)
Received: from 168.78.233.220.exetel.com.au ([220.233.78.168]
	helo=[192.168.1.2]) by smtp.po.exetel.com.au with esmtp (Exim 4.68)
	(envelope-from <Ben.Stanley@exemail.com.au>) id 1KPcyZ-0007h1-9o
	for alsa-devel@alsa-project.org; Sun, 03 Aug 2008 22:46:19 +1000
In-Reply-To: <1215086952.30056.190.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2008-07-03 at 22:09 +1000, Ben Stanley wrote:
> Hi,
> 
> I am having some problems getting sound out of a ca0106 card using
> SPDIF. I have enabled SPDIF output using alsamixer. Some programs
> produce sound, and others stubbornly don't.
> 

After much messing around, this problem is now understood. I have a
workaround. I want to start a discussion about the best way of solving
it permanently.

It turned out to be that the 'audio' bit of the SPDIF AES setting was
set to 'non-audio'. This has the unfortunate effect of preventing any
PCM stream from working, while Dolby Digital and DTS work just fine.
This explains the reported symptoms perfectly.

(I eventually tracked down the problem by examining the state and
meaning of all of the registers used by the ca0106 driver, for working
and non-working streams. I narrowed my search by diffing the register
dumps and focusing on the differing register values.)

The non-audio bit is bit 2 in AES0. Setting AES0=0x2 asserts the
'non-audio' bit (DD or DTS), while setting AES0=0x0 indicates audio
(PCM) data.

It seems that MythTV understands how to set the AES settings, and
correctly sets the non-audio bit when playing DD and DTS streams. When
it has finished playing such a stream, it restores the previous AES
settings. Unfortunately, if MythTV crashes before restoring the
settings, the non-audio setting remains. Other programs which don't pay
attention to the AES settings then fail to output any sound (because
their PCM data is incorrectly marked as 'non-audio').

Once the 'non-audio' bit is set in such a manner, not even a re-boot
fixes the issue. This is because the state of the driver is saved by
alsactl to the file /var/lib/alsa/asound.state on shutdown, and restores
it on boot. My temporary fix was to edit (This information is probably
specific to ca0106)

        control.18 {
                comment.access 'read write'
                comment.type IEC958
                comment.count 1
                iface PCM
                name 'IEC958 Playback Default'
                index 1
                value
'0282000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
        }
The fix is to clear the 2 in the first byte of the hexadecimal value. In
my case, the value is now
'0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
After editing and saving the file, re-load the configuration using the
command
# alsactl restore
If you have more than one card, check the man page for the appropriate
incantation.

If you don't want to modify your settings permanently, you can use the
following commands to test if this problem affects you by manually
setting the AES values on the command line, as follows (this is probably
generic to all cards with SPDIF):

For example, this works for me:
speaker-test --device=iec958:AES0=0x0,AES1=0x92,AES2=0x10,AES3=0x2
--channels=2

and this produces no audio output for me (by setting the non-audio
flag):
speaker-test --device=iec958:AES0=0x2,AES1=0x92,AES2=0x10,AES3=0x2
--channels=2

So in summary, the problem occurred because most applications don't seem
to understand/assert AES settings for SPDIF. In the case where it is set
to 'audio', this is fine, but where the registers are set to
'non-audio', this causes *no audio output* for all PCM streams.

Now for some hard questions. I want to start some discussion around
these points before I try to solve this problem permanently.

* Whos responsibility is it to set the state of the audio/non-audio bit?
ALSA-driver? alsa-lib? application? I believe it should be *set*
appropriately for each opened stream.
* Is there a good reason why iecset does not work with device names like
hw:0,0 , hw:0,1 , hw:0,2 etc? (I could probably fix this...)


On Thu, 2008-07-03 at 22:09 +1000, Ben Stanley wrote:
> Hi,
> 
> I am having some problems getting sound out of a ca0106 card using
> SPDIF. I have enabled SPDIF output using alsamixer. Some programs
> produce sound, and others stubbornly don't.
> 
> I need some hints about what to try next, what information I could look
> at, to be able to diagnose some factor common to the failures, and
> hopefully the cause.
> 
> I am familiar with part of the driver, I have already written a patch
> which used to enable 44.1kHz output on an earlier Ubuntu.
> 
> Anyway, the details are all recorded below. I would appreciate it if a
> patient person could have a look through and throw me some ideas.
> 
> Thanks,
> Ben Stanley.
> 
> 
> I did a git checkout yesterday and built alsa 1.0.17rc3 on Ubuntu 8.04
> kernel 2.6.24-19-generic.
> 
> I used the following configure options:
> ./configure --with-debug=full --with-cards=ca0106
> --with-moddir=/lib/modules/`uname -r`/alsa-driver-orig
> 
> (I am using the --with-moddir to avoid clobbering the distro alsa
> modules. I am selecting which modules to use by editing /etc/depmod.conf
> and changing the priority order, and then re-running depmod. I can
> verify the result by checking /var/lib/`uname -r`/modules.dep .)
> 
> Everything builds and installs without any warnings or errors.
> 
> So, after all that, I tested three applications:
> MythTV
> xine
> speaker-test
> 
> My sound output is via SPDIF to a Yamaha RX-V557 digital amplifier.
> 
> I only get sound out of MythTV. I get nothing out of xine (playing
> flacs) or out of speaker-test. However, I do get signal out of xine
> playing DVDs.
> 
> Details:
> ================================================================
> speaker-test --device-hw:0,0 --channels=2 --rate=48000
> This should work, but instead it produces no SPDIF output. The amplifier
> shows no digital signals.
> 
> root@mythtv:/proc/asound/card0/pcm0p/sub0# cat hw_params 
> access: RW_INTERLEAVED
> format: S16_LE
> subformat: STD
> channels: 2
> rate: 48000 (48000/1)
> period_size: 4096
> buffer_size: 16384
> 
> ================================================================
> Testing with xine playing a 44100Hz stereo S16_LE flac:
> root@mythtv:/proc/asound/card0/pcm0p/sub0# cat hw_params 
> access: MMAP_INTERLEAVED
> format: S16_LE
> subformat: STD
> channels: 2
> rate: 48000 (48000/1)
> period_size: 1024
> buffer_size: 8192
> 
> The amplifier says 'Unknown Digital', NO SOUND PRODUCED.
> 
> ================================================================Testing
> with xine playing 'Riverdance' DVD in DTS surround with AC3 Passthrough:
> Sound output WORKS
> Amplifier says 48kHz DTS
> root@mythtv:/proc/asound/card0/pcm0p/sub0# cat hw_params 
> access: RW_INTERLEAVED
> format: S16_LE
> subformat: STD
> channels: 2
> rate: 48000 (48000/1)
> period_size: 2048
> buffer_size: 16384
> 
> ================================================================
> Running MythTV: Configured to open ALSA:hw:0,0 directly.
> root@mythtv:/proc/asound/card0/pcm0p/sub0# cat hw_params 
> access: MMAP_INTERLEAVED
> format: S16_LE
> subformat: STD
> channels: 2
> rate: 48000 (48000/1)
> period_size: 8192
> buffer_size: 16384
> 
> The amplifier identifies this as a 48kHz PCM signal.
> Sound output WORKS.
> ================================================================
> 
> As a general observation, this problem was present in Ubuntu 7.10, but
> was 'intermittent' (I used to be able to get speaker-test and xine
> playing flacs to work most of the time.) The failures now seem to be
> permanent after upgrading to Ubuntu 8.04, whether latest alsa-git is
> installed or not.
> 
> Now, I need some ideas for what to look for here. I can't see
> differentiating factor between things that work and things that do not.
> Perhaps I need to look at some registers.
> I don't know what relationship the files at 
> /proc/asound/CA0106/ca0106_reg*
> have to the registers declared in
> alsa-kmirror/pcm/ca0106/ca0106.h
> but I think I understand the registers from the header file.
> 
> Ideas please?
> 
> Once I get this sorted out I can test my patch allowing 44100Hz sampling
> rates to be output to SPDIF. At the moment this bug is preventing me
> from testing...
> 
> Thanks,
> Ben Stanley.
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
