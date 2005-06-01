From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA Plugin for XMMS2. Help wanted.
Date: Wed, 1 Jun 2005 09:54:44 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0506010952460.6195-100000@studcom.urz.uni-halle.de>
References: <Pine.HPX.4.33n.0505311333490.7269-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0505311333490.7269-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?ISO-8859-1?Q?Tobias_Rundstr=F6m?= <tru@xmms.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Tobias Rundstr=F6m wrote:
> [...]

Some further remarks:

In the call to xmms_plugin_new, the string literal in the last
parameter includes several tab characters from the beginning of the
second line.

xmms_alsa_probe_modes should check the return value of snd_pcm_open,
and use SND_PCM_NONBLOCK, too.

xmms_alsa_buffer_bytes_get should check for return values other than
-EPIPE.


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=3Doffad-ysdn-ostg-q22=
005
