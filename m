From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: Re: unresolved symbol udelay with ALSA on PPC
Date: Mon, 13 May 2002 12:34:56 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CDF96D0.44405B4E@folkwang-hochschule.de>
References: <3CDF867F.44DA2DAD@folkwang-hochschule.de> <s5hsn4w8k0t.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

takashi, jaroslav, thanks for your quick replies. cvs compiles and runs.
problem is, i hear no sound. 


Takashi Iwai wrote:
> 
> i hope it was fixed on cvs now.
> (as always, it's due to missing include..)
> could you try to update?
> 
> anyway, i'll spend some time to debug powermac drivers in this week.
> there have been bug reports regarding awacs/screamer chips.

here's another (screamer/awacs):

ephraim:/ # amixer
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined
  Playback channels: Front Left - Front Right
  Capture channels: Mono
  Limits: Playback 0 - 15
  Mono: Capture [on]
  Front Left: Playback 11 [73%] [on]
  Front Right: Playback 11 [73%] [on]
Simple mixer control 'Line',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [on]
Simple mixer control 'CD',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [on]
Simple mixer control 'Mic',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [on]
Simple mixer control 'Mic Boost',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'PC Speaker',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 15
  Front Left: Playback 15 [100%] [on]
  Front Right: Playback 15 [100%] [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 15 [100%]
  Front Right: Capture 15 [100%]
Simple mixer control 'Beep',0
  Capabilities: pvolume pvolume-joined
  Playback channels: Mono
  Limits: Playback 0 - 100
  Mono: Playback 55 [55%]

i can aplay a wav, but i don't hear anything, no matter how i switch
around...

the switches look weird to me:

master is a gain slider, mutable and recordable. ok.
line, cd and mic are just capture switches, neither gain nor mute. and
they are non-exclusive. by default, all 3 are set to capture.
mic boost is just a mute switch, which is probably what it should be.
pc speaker is a mutable gain slider like it used to be.
capture can't  be muted, but i think that's how the hardware is.
beep looks ok.


> the tumbler chip was fixed in the last week.
> now it supports bass/treble and DRC, and the volume changes more
> reasonably.
> 
> Takashi

--
Watch out where the huskies go and don't you eat
the yellow snow !
	- Frank Zappa

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
