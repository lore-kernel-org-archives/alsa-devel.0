From: Joshua Haberman <joshua@haberman.com>
Subject: Re: [linux-audio-dev] ok, jump on slashdot right now, ALSA story in progress
Date: Fri, 1 Nov 2002 22:46:25 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021101224625.05d7285f.joshua@haberman.com>
References: <200211020410.gA24Aew14655@linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200211020410.gA24Aew14655@linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: linux-audio-dev@music.columbia.edu, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis <paul@linuxaudiosystems.com> wrote:
> i don't want to blow my moderator points this time, so get busy. there
> is lots of confusion, mis-information and general cluelessness in the
> responses so far. get to it, provide me with some stuff to moderate
> upward ...

What a coincidence: I've had brewing in my mind in the last two days an
ALSA usability project.  It would be pointless to post to /. about it,
so let me braindump here since I could actually get informed replies. :-)

Here are my primary goals:

1.  Work on getting discover [0] to work with ALSA.  discover is a project
    developed by Progeny, designed to detect what hardware is available
    and provide that information to userspace programs via the library
    libdiscover.  It works reasonably well, but at this point only supports
    OSS.  I wrote to the mailing list yesterday asking questions about
    how ALSA could be supported [1].

    I believe this is a very promising project: here is an example of
    the output on my machine:

    $ sudo discover all
    Silicon Integrated Systems (SiS) SG85C503
    Unknown LITEON DVD-ROM LTD163D
    Silicon Integrated Systems (SiS) SiS900 10/100 Ethernet
    Realtek Semiconductor Co., Ltd. RTL-8139
    Silicon Integrated Systems (SiS) 5513 [IDE]
    Linux IDE-SCSI emulation layer
    Creative Labs SB Live! EMU10000
    Silicon Integrated Systems (SiS) 7001
    Silicon Integrated Systems (SiS) 7001
    Silicon Integrated Systems (SiS) SG86C201
    NVIDIA Corporation GeForce [NV11]
    Unknown WDC WD1200AB-00CBA1
    Unknown ST360021A
    $ sudo discover --module all | sort -u
    emu10k1
    ide-scsi
    rtl8139
    sis900
    usb-ohci

2.  Modify the ALSA drivers to put something useful in the card ID.  Right
    now you get card0, card1, etc., which is completely useless: if you wanted
    to refer to the card by number, you'd just write hw:0.

    Why is the card ID important?  Because it can be used to enumerate and
    select cards, the way other audio APIs will let you do!  Using the syntax
    hw:CARD=cardid you can select a device based on human-readable strings.
    Today I get:

    $ cat /proc/asound/cards 
    0 [card0          ]: EMU10K1 - Sound Blaster Live!
                         Sound Blaster Live! at 0xcc00, irq 11
    1 [card1          ]: ICH - SiS SI7012
                         SiS SI7012 at 0xd800, irq 11

    My goal is:

    $ cat /proc/asound/cards 
    0 [SBLive         ]: EMU10K1 - Sound Blaster Live!
                         Sound Blaster Live! at 0xcc00, irq 11
    1 [SiS SI7012     ]: ICH - SiS SI7012
                         SiS SI7012 at 0xd800, irq 11

    It is possible to set these with arguments to modprobe, but that's no
    reason why they shouldn't be useful by default.

3.  Documentation on how to write user-friendly device selection for ALSA.
    If common apps started getting this right, ALSA would provide a directly
    visible value-add for end-users, since OSS can only let you choose between
    /dev/dsp1, /dev/dsp2, etc (AFAIK).

    Alternatively, encourage people to use PortAudio since it will provide
    this transparently.

    Alternatively, investigate the possibility of being able to run more
    than one jackd at a time, one for each sound card.  Running a single
    jackd for more than one sound card is infeasable since two cards can
    never be perfectly synced.  The point of this being that the user would
    again see the advange of being able to easily select the desired sound
    card for output, with the added advantage of being able to share the
    sound card.

I believe that these things alone would make ALSA *much* more usable for
simple, stereo users that perhaps have more than one sound card.  The
hw:0 stuff is a drag, as is trying to find out what module goes with your
card and modprobing it.

I'm interested in input from multichannel users regarding what kind of
usability improvements ALSA could use in this arena.  To be honest, I have
no idea how ALSA works with multichannel cards since I don't have any.

Comments welcome.

Josh

[0] http://hackers.progeny.com/discover/
[1] http://lists.progeny.com/archive/discover-workers/200211/msg00000.html

-- 
"Only Angels can sing that high, and only dogs can hear it."  -- James Evans


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
