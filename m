From: James Tappin <james@tappin.me.uk>
Subject: Re: the last changes to trident driver
Date: Tue, 7 Jan 2003 19:33:19 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030107193319.608f79c3.james@tappin.me.uk>
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
> thanks in advance,
> 
> Takashi

Hi Takashi.

I get a problem with the gameport options not resolving with the following build.

00:09.0 Multimedia audio controller: Trident Microsystems 4DWave NX (rev 02)

./cvscompile --with-cards=trident --with-sequencer --without-isapnp --with-oss

gabrielle:/gsoft/build/ALSA/CVS/alsa-driver# /sbin/depmod -ae 2.4.20
depmod: *** Unresolved symbols in /lib/modules/2.4.20/kernel/sound/pci/trident/snd-trident.o
depmod:         gameport_unregister_port_R70daab68
depmod:         gameport_register_port_R98692e58

Best regards,
	James

-- 
James Tappin,             O__      "I forget the punishment for using
james@tappin.me.uk       --  \/`    Microsoft --- Something lingering
http://www.tappin.me.uk/            with data loss in it I fancy"  


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
