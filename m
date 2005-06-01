From: =?ISO-8859-1?Q?Tobias_Rundstr=F6m?= <tobi@tobi.nu>
Subject: Re: ALSA Plugin for XMMS2. Help wanted.
Date: Thu, 02 Jun 2005 00:38:23 +0200
Message-ID: <429E38DF.4020204@tobi.nu>
References: <Pine.HPX.4.33n.0506010952460.6195-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0506010952460.6195-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: =?ISO-8859-1?Q?Tobias_Rundstr=F6m?= <tru@xmms.org>, alsa-devel@lists.sourceforge.net, andersg@xmms.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Tobias Rundstr=F6m wrote:
>=20
>>[...]
>=20
>=20
> Some further remarks:
>=20
> In the call to xmms_plugin_new, the string literal in the last
> parameter includes several tab characters from the beginning of the
> second line.
>=20
> xmms_alsa_probe_modes should check the return value of snd_pcm_open,
> and use SND_PCM_NONBLOCK, too.
>=20
> xmms_alsa_buffer_bytes_get should check for return values other than
> -EPIPE.

Thanks for all help. We have started to work on ALSA again, some of the=20
fixes you suggested was included in XMMS2 DR1.1 that was released earlier=
.

We realized that all our current plugins where blocking during=20
open/probing. This will change to DR2. Thanks for noticing.

Visit http://git.xmms.se/?p=3Dxmms2.git;a=3Dsummary to track our progress=
.

Greetings
Tobias


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
