From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 latency / capture period
Date: Fri, 18 Jun 2004 19:26:33 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1087601193.1073.15.camel@debian>
References: <40D1E4E7.8000704@joe-job.com>
	 <200406172326.i5HNQkQV017899@dhin.linuxaudiosystems.com>
	 <s5hacz1p5vd.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hacz1p5vd.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel@lists.sourceforge.net, pzad@pobox.sk
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-06-18 at 05:33, Takashi Iwai wrote:

> But my guess is that ASIO uses the playback interrupt
> for capture, too.
> 

A few thing I noticed looking at the code is that the FXBus 
channels are only available as a playback device.  Shouldn't 
these also be capture devices?  This implies that the FXBus 
channels cannot be used for multichannel recording.  Is this 
correct?

Maybe modifying the driver to expose the FXBus channels as capture
devices is all that is needed.  This is really how the hardware 
works - the channels act as buses, so it's simultaneously a playback 
and a capture device.

rlrevell@debian:$ cat /proc/asound/pcm
00-00: emu10k1 : EMU10K1 : playback 32 : capture 1
00-01: emu10k1 mic : EMU10K1 MIC : capture 1
00-02: emu10k1 efx : EMU10K1 EFX : capture 1
00-03: emu10k1 : EMU10K1 FX8010 : playback 8

I also noticed that the driver only seems to be aware of 16 FXBus
channels - the Audigy has 32.  This I am going to take a shot at fixing
myself.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
