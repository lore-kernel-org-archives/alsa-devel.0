From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] patch_cm9880.c to support multi-channel
Date: Thu, 24 Mar 2005 14:30:21 -0500
Message-ID: <1111692621.8268.21.camel@mindpipe>
References: <92C0412E07F63549B2A2F2345D3DB515F7D6C6@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id D772B256
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2005 20:30:23 +0100 (MET)
In-Reply-To: <92C0412E07F63549B2A2F2345D3DB515F7D6C6@cm-msg-02.cmedia.com.tw>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "\"Tien,  C.L. - =?UTF-8?Q?=E7=94=B0=E6=89=BF=E7=A6=AE=22?=" <cltien@cmedia.com.tw>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-03-25 at 01:53 +0800, "Tien, C.L. - =E7=94=B0=E6=89=BF=E7=A6=
=AE" wrote:
> Summary: <fix multi-channel for model=3D=3Dfull>
> Signed-off-by: ChenLi Tien<cltien@cmedia.com.tw>
>=20
>=20
> Hi,
>=20
> The patch_cm9880.c can't play side/C/B channels from front panel jacks.=
 I fixed it by adding select pin.
>=20
> I also added controls in the allout_init array. I wonder what this mode=
l for because it is the same as basic_init except the line-in is used as =
output in allout_init.
>=20
> I plan to add controls for 5/6 stacks ,  which lacks front panel but ha=
s rear 5/6 jacks. Any idea?
>=20
> Sincerely,
> ChenLi Tien

Was there supposed to be a patch attached?

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
