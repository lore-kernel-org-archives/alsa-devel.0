From: Oliver Schinagl <oliver@schinagl.nl>
Subject: emu10k1 mute problems.
Date: Fri, 08 Dec 2006 20:16:08 +0100
Message-ID: <4579B9F8.4020109@schinagl.nl>
References: <000e01c7165d$ceeebaf0$dedde354@dwnze>
	<20061203183433.GA14091@inferno.domain.actdsltmp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061203183433.GA14091@inferno.domain.actdsltmp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I am wondering if there's a bugzilla or some place to drop a bugreport 
for my SBLive! (emu10k1)?

I have in my system 2 soundcards installed, an SBLive! emu10k1 (
00:0e.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
        Subsystem: Creative Labs SBLive! Player 5.1
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at ef20 [size=32]
        Capabilities: [dc] Power Management version 1
)
and an Onboard VIA audio thinger (
00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
        Subsystem: ASUSTeK Computer Inc. Unknown device 810d
        Flags: medium devsel, IRQ 20
        I/O ports at 1000 [size=256]
        Capabilities: [c0] Power Management version 2

)

on a gentoo 2.6.19-r1 kernel

Now they both are working but there's one thing that seems to be going 
wrong. Since it only happens on the SBLive (the via onboard works as it 
should) it must be a bug in the emu10k1 driver.

I use the following code to mute the left resp. right channels.

    snd_mixer_selem_set_playback_switch(elem, SND_MIXER_SCHN_FRONT_LEFT, 0);
    snd_mixer_selem_set_playback_switch(elem, 
SND_MIXER_SCHN_FRONT_RIGHT, 0);

However, when muting the left channel, both channels get muted. When 
muting the the right channel, none get muted. It's not just my app that 
shows this behavious, gkrellm-volume plugin for instance does the same 
thing (wrong).


Since there aren't really much mixers that do balance properly, there 
isn't much other volume controls I can test this with. I do however 
notice in alsamixer, that below the bar, it says [MM] or [OO] on the 
SBLive!, but with the Via, I get all possibilities done, including [MO] 
or [OM].

Thanks,

Oliver

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
