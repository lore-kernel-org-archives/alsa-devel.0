From: "Jared D. McNeill" <jared.mcneill@gmail.com>
Subject: Re: intel8x0m and conexant ac97 modem codecs
Date: Wed, 13 Apr 2005 19:53:20 -0300
Message-ID: <41d6f0b9050413155325e269c4@mail.gmail.com>
References: <41d6f0b90504120905d469db0@mail.gmail.com>
	 <1113329101.31159.23.camel@mindpipe>
	 <41d6f0b905041211143edfd71e@mail.gmail.com>
	 <20050413212806.GB1096@tecr>
Reply-To: "Jared D. McNeill" <jared.mcneill@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050413212806.GB1096@tecr>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Jared D. McNeill" <jared.mcneill@gmail.com>, Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net, jmcneill@netbsd.org
List-Id: alsa-devel@alsa-project.org

On 4/13/05, Sasha Khapyorsky <sashak@smlink.com> wrote:
> There was same 0xff00 with some non-Connexant modems too. Look for recent
> modem related patches in asla-kernel/pci/ac97/ac97_codec.c - it solves
> '0xff00'.

I'll have a peek, thanks for the heads-up.

> About Conexant codec and intel8x0m: I don't know how to run it too and
> there are few reports in alsa-project bug db.

The majority of the NetBSD developers I've discussed this with are
unfortunate enough to have Conexant codecs. I've only done the driver
work for our auich (ICH audio driver), since I don't have any of the
other hardware handy. One of our developers has a Silicon Labs codec,
and he's able to take his modem off-hook and read/write audio without
a problem.

> Some data sheets are here ftp://ftp.alsa-project.org/pub/datasheets/conex=
ant,
> but it is unclear (for me) how to hook-off line. I'm looking for CXT "inf=
ected"
> machine (hope playing with register may help), but didn't find it yet. Do=
 you
> have one? (BTW: as reported it is IBM TP X40 and higher X, TP R50e, Aspir=
e 1692WLI,
> ASUS a3n and some others).

I've looked at the SmartMC II datasheet -- it doesn't even document
the EXT_MODEM_CTRL register! From what I've read about Conexant HSF
modems, it looks like the majority of them need firmware to be loaded
before they're usable; I don't see any documentation on how to do this
in the AC-Link version, but I wouldn't be suprised if this was the
case.

I'm unfortunate enough to have a CXT codec in my laptop (Dell Latitude D600=
):
  auich1 at pci0 dev 31 function 6: i82801DB (ICH4) AC-97 Modem
  auich1: interrupting at irq 11
  auich1: ac97: Conexant D480 MDC V.92 Modem codec; no 3D stereo
  auich1: ac97: ext mid 4001<LINE1>, secondary codec
  auich1: codec not responding, status=3D0xff00

I've had reports that the NetBSD driver is now talking to non-Conexant
codecs just fine. Since I can't power on my Conexant codec, I can't
test this.

Once I get this working, I can finally continue my work on porting
slmodem to the NetBSD audio subsystem.

Thanks!

Cheers,
Jared


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
