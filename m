From: "yvan chenard" <mte_multi@hotmail.com>
Subject: loopback with hda-intel
Date: Mon, 19 Jun 2006 11:26:49 -0400
Message-ID: <BAY20-F146F1DFE9D67B23CD23EFF85860@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi, maybe someone can help me,

I find no ways to route (loop_back) the Line-in(where I have my tv-tuner =

pluged in) to
the headphone jack, maybe someone know how to do it or know any links on
documentation on how to do it.

The sound card is onboard Intel D945GTP
the chipset is STAC9220 (from sigmatel) (HDA_intel compatible)
I am runing ALSA 1.0.11 not in the kernel(as module).
kernel 2.6.16.5.

The only way to get sound from LineIn to HeadPhone right now is
"cat /dev/dsp > /dev/audio", but the quality is realy bad( with this
command I know that the configuration of the input and output is OK).

Thank You for your time.

Yvan

_________________________________________________________________
Regardez des vid=E9oclips sur Sympatico / MSN Vid=E9o! =

http://video.msn.com/v/fr-ca/v.htm?t=3Dc275&f=3D38/82&p=3DFRCAmusique_FRCAv=
ideos
