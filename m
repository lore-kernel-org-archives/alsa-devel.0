From: Jason Harvey <softdevice@jasonline.co.uk>
Subject: sbxfi - What works/doesn't summary
Date: Tue, 28 Oct 2008 11:42:04 +0000
Message-ID: <4906FA8C.4030501@jasonline.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homer.jasonline.co.uk (78-86-168-217.zone2.bethere.co.uk
	[78.86.168.217]) by alsa0.perex.cz (Postfix) with ESMTP id 184B2243F4
	for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2008 12:42:02 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> It'd be helpful if someone can summarize the working and non-working
> cases.  For example,
>
> global info:
> 0. SBXFI model (product name, PCI ID, PCI SSID, cat /proc/asound/cards
> entry)
> 1. sbxfi driver version (date & HEADs)
> 2. base_rate value
> 3. system details (x86-64, distro, kernel version, etc)
>
> for each app:
> A. Application name / version
> B. working or not-working, problem descriptions
> C. ALSA or OSS (you can see it in /proc/asound/card*/pcm0/sub0/hw_params)
> D. period_size and buffer_size (ditto, or in kernel message)
> E. any special options
>
> Maybe also nice on Wiki...

Hi,

Here's my setup and what's currently working.

0. [SB0550         ]: SBXFi - SB XFi (SB0550)
                      SB XFi (SB0550) at 0x3040 irq 28

1. sbxfi driver version (date & HEADs)
    26 Oct 2008
    ./HEAD - 8682b8b4ced855b01639d85098ca7de23db87c3d Merge branch 
'topic/snd-hrtimer'
    ./alsa-kernel/HEAD - 8f5d017c10e9da0b1e06f674bfc2c764192d090b Merge 
branch 'topic/sbxfi'

2. base_rate - 48000

3. x86_64, Fedora 9, 2.6.26.6-79.fc9.x86_64

APPS TESTED

Mplayer -  dev-SVN-r27841-4.3.0

    WORKING

    cat /proc/asound/card0/pcm0p/sub0/hw_params

    access: RW_INTERLEAVED
    format: S16_LE
    subformat: STD
    channels: 2
    rate: 48000 (48000/1)
    period_size: 1024
    buffer_size: 16384
    OSS format: S16_LE
    OSS channels: 2
    OSS rate: 48000
    OSS period bytes: 4096
    OSS periods: 16
    OSS period frames: 1024


Firefox 3.0.2 flash-plugin-10.0.12.36-release.i386

    WORKING

    cat /proc/asound/card0/pcm0p/sub0/hw_params
    access: MMAP_INTERLEAVED
    format: S16_LE
    subformat: STD
    channels: 2
    rate: 48000 (48000/1)
    period_size: 1024
    buffer_size: 16384

Enemy Territory Quake Wars worked but crashed after a couple of minutes. 
Graphics card is new so can't be sure what happened.

If I set Gnome to use OSS I can get sound from Rhythmbox.


Sorry to tag this on to the end of this message, the problems below are 
likely of my own causing rather than the sbxfi driver...

I'm investigating why when I select alsa or pulse in Gnome I get an 
error on clicking the test button.
"audiotestsrc wave=sine freq=512 ! audioconvert ! audioresample ! 
gconfaudiosink: Could not open audio device for playback."
Selecting OSS and clicking test I hear the sine wave.
But I cannot hear any desktop effect noises or the system bell.
Same issue with KDE. I hear the log on tune but nothing else from the 
desktop itself.
Possibly my machine is just too messed up and needs a re-install, it's 
been upgraded continuously from around FC3 and could do with an overhaul.

Regards, Jason
