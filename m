From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: [PATCH]snd-usb-usx2y 0.7.1 against cvs head:     
     please test it!
Date: Tue, 13 Jul 2004 23:12:26 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32788.192.168.1.5.1089756746.squirrel@www.rncbc.org>
References: <200407131155.43747.annabellesgarden@yahoo.de>  
    <s5hwu17andn.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwu17andn.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Martin Langer <martin-langer@gmx.de>, Werner Schweer <ws@seh.de>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Karsten Wiese wrote:
> Hi,
> this module version sports "no sleeping" in ALSA's pcm START/STOP
> callbacks.
> It could need a little more testing, as the changes are many.
> Here it works well with kernels "planet CCRMA's 2.4.26" and "vanilla
> 2.6.7 all debug flags I found enabled".

Just built from cvs against a custom 2.6.7-cko6 kernel on a SUSE 9.1
SMP/HT box, and assured that the patch is already applied.

Erm... I get the following while modprobing snd-usb-usx2y:

WARNING: Error inserting snd_hwdep
(/lib/modules/2.6.7-cko6.0smp/kernel/sound/acore/snd-hwdep.ko): Unknown
symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_usb_usx2y
(/lib/modules/2.6.7-cko6.0smp/kernel/sound/snd-usb-usx2y.ko): Unknown
symbol in module, or unknown parameter (see dmesg)

Then the relevant dmesg says:

snd_hwdep: Unknown symbol snd_kcalloc
snd_usb_usx2y: Unknown symbol snd_hwdep_new

So I guess something went wrong on my snd-usb-usx2y build. OTOH, the
onboard snd-intel8x0 based is loaded and working without a glitch.

So, too pity I can't get my us224 onto the testing right now.

Any ideas?
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
