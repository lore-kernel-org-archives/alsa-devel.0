From: James Tappin <james@tappin.me.uk>
Subject: Re: the last changes to trident driver
Date: Tue, 7 Jan 2003 23:20:51 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030107232051.2861d226.james@tappin.me.uk>
References: <s5hn0md9c9s.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0md9c9s.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 07 Jan 2003 17:04:47 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> Hi,
> 
> if someone has a Trident 4DNX (not DX), could you test the latest CVS
> driver?  i hope my last change doesn't break, but i couldn't test the
> board atm...
> 
> 

Hi Takashi,
	I've managed to resolve my unresolved references problem by rebuilding
the kernel without gameport support, but now attempting to aplay a wav
file produces an immediate segfault (but it refuses to dump core).
Likewise gwc which uses the OSS interface. Also attempting to restart alsa
now (after the gwc crash) gives a series of device busy messages:

Shutting down sound driver: snd-pcm-oss: Device or resource busy
snd-mixer-oss: Device or resource busy
snd-trident: Device or resource busy
snd-pcm: Device or resource busy
snd-timer: Device or resource busy
snd-ac97-codec: Device or resource busy
snd-mpu401-uart: Device or resource busy
snd-rawmidi: Device or resource busy
snd-util-mem: Device or resource busy
snd-seq-device: Device or resource busy
snd: Device or resource busy
done

So at least for me right now it looks well-and-truly busted. If you can
let me know what further info you need and how to get it I'll try to
provide it though it make take a little while if any major builds are
needed as the box with the trident in it isn't exactly the fastest in the
world (PII 333).

James

-- 
James Tappin,             O__      "I forget the punishment for using
james@tappin.me.uk       --  \/`    Microsoft --- Something lingering
http://www.tappin.me.uk/            with data loss in it I fancy"  


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
