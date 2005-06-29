From: christophe barbe <christophe@cattlegrid.net>
Subject: Re: intel8x0 ACPI suspend/resume bug
Date: Wed, 29 Jun 2005 11:01:40 -0400
Message-ID: <20050629150139.GB8460@cattlegrid.net>
References: <20050628150638.GB6677@cattlegrid.net> <s5hacl97blk.wl%tiwai@suse.de> <1120052108.14654.3.camel@localhost.localdomain> <20050629143619.GA8460@cattlegrid.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050629143619.GA8460@cattlegrid.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 29, 2005 at 10:36:19AM -0400, christophe barbe wrote:
> I have not yet find how the volume is encoded but I suspect it's two 8-=
bit words one for the left and one for the right which seems to match the=
 fact that I usually loose the sound on one side. But all registers seems=
 to be unrelated to mp3-to-pcm output.

I found the description of the registers in the AC'97 spec and it says
that the bit7 of the registers 10,12,16 and 1c should read 0 (as they
are marked X in the table).
Is this correct?

Interestingly this bits read 1 before a suspend/resume cycle but 0
after. This is really strange.

Christophe

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
