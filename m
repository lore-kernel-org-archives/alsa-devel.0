From: "Jared D. McNeill" <jared.mcneill@gmail.com>
Subject: Re: intel8x0m and conexant ac97 modem codecs
Date: Wed, 13 Apr 2005 21:33:12 -0300
Message-ID: <41d6f0b905041317332c366671@mail.gmail.com>
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

Are you talking about rev. 1.183 of ac97_codec.c ? If so, we already
do this in NetBSD. No dice in the Conexant case.

Cheers,
Jared


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
