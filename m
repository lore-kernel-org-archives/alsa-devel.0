From: Glenn Maynard <g_sf@zewt.org>
Subject: Re: EMU10K1 and the extra voice
Date: Sun, 6 Jun 2004 00:54:31 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040606045431.GA3025@zewt.org>
References: <20040605125936.GA3478@lost.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040605125936.GA3478@lost.org.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 05, 2004 at 12:59:36PM +0000, Chris Purnell wrote:
> For PCM playback the EMU10K1 driver is allocating an extra voice.
> This is somewhat wastefull and I kind of need all 64 voices.
> Is appears to be using it to generate the period interrupts.
> Does anyone know what it would take to rewrite the driver to
> not need this extra voice?

Any relationship to the fact that I can only allocate 21 subdevices with ALSA,
but 31 with DirectSound?

ALSA: Advanced Linux Sound Architecture Driver Version 1.0.4rc2 (Tue Mar 30 08:19:30 2004 UTC).
ALSA Driver: 0: Sound Blaster Live! [Live], device 0: emu10k1 [EMU10K1], 32/32 subdevices avail
ALSA Driver: 0: Sound Blaster Live! [Live], device 3: emu10k1 [EMU10K1 FX8010], 8/8 subdevices avail
ALSA: dsnd_pcm_hw_params: Cannot allocate memory
ALSA: Got 21 hardware buffers

vs

DirectSound Driver: SB Live! Audio [FF80] (ctaud2k.sys)
    ID: {bd6dd71a-3deb-11d1-1252b90}
DirectSound sample rates: 4000..191999 (continuous)
Got 31 hardware buffers

-- 
Glenn Maynard


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
