From: Erik Slagter <erik@slagter.name>
Subject: Re: SPDIF/IEC958 sample rate on HDA/ALC882
Date: Mon, 11 Dec 2006 13:50:58 +0100
Message-ID: <457D5432.1070402@slagter.name>
References: <4548D24F.7080409@slagter.name> <s5hhcwj4u0s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hhcwj4u0s.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>> Maybe I am using the wrong "hw", there is also a "hw:0,2" device, which
>> I cannot make work properly at all (only one channel is output, large
>> chunks are discarded, much much clipping).

> The first PCM device is for the multi-output PCM.  It's for both
> analog and digital.  The dedicated SPDIF is the secondary one.

I've been experimenting at large yesterday, and I now I finally
understand what you mean by this sentence.

It appears that if you send output to hw:0,0 which comprises of
two-channel data AND the iec958 enable control is set to on, then the
hw:0,1 is also opened (returns "busy" on open) and the sound is sent to
that device simultaneously. If the amount of channels is other than 2,
then this scheme is not followed, and the secondary interface remains
available. If the iec958 enable control is set to false, none of the
hw:0,0 or hw:0,1 output data to spdif.

Is this intended behaviour? I think it is very very confusing. IMHO the
alsa lib has enough features to copy sound to both devices, when the
user actually wants that. And I don't! hw:0,0 should simply output to
analog en hw:0,1 to digital... At least the user should be able to
choose the behaviour using the iec958 enable control, being "on"
implementing the current "copying" behaviour and otherwise simply
exposing two independent devices.

Oh and BTW the bug I reported earlier on, with the hw:0,1 (digital)
interface giving noise in one channel, appears to be really a bug, with
a workaround, so it might be a simple one to resolve; if you output
sound to the device and toggle the iec958 control a few times, the noise
goes away and the interface works OK. Looks like an initialisation
problem to me...

This is all with vanilla linux 2.6.19 (alsa 1.0.13).

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
