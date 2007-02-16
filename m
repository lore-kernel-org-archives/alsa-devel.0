From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Edirol UA-25 dmix broken at 48 Khz
Date: Fri, 16 Feb 2007 12:33:14 +0100
Message-ID: <1171625594.23742.1174966389@webmail.messagingengine.com>
References: <1171621576.4524.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1171621576.4524.2.camel@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: =?ISO-8859-1?Q?Jean-Michel=20Pour=E9?= <jmpoure@free.fr>, Alsa Dev <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jean-Michel Pour=E9 wrote:
> ALSA lib pcm_direct.c:897:(snd_pcm_direct_initialize_slave) requested or =
auto-format is not available

You're using an old version of the ALSA library that doesn't yet support
24-bit samples.  Install alsa-lib 1.0.11 or later.


HTH
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
