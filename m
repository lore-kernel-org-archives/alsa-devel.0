From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: buffer_bytes not multiple of period_bytes
Date: Thu, 20 Apr 2006 09:17:24 +0200 (CEST)
Message-ID: <XFMail.20060420091724.pochini@shiny.it>
References: <4446E9DE.4080709@kenati.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4446E9DE.4080709@kenati.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Carlos Munoz <carlos@kenati.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 20-Apr-2006 Carlos Munoz wrote:
> Hi all,
>
> I just noticed that alsa doesn't allocate a buffer size that is a
> multiple of the period size.

It's not required. If it is not a multiple, then the IRQ happens
in different points of the ring buffer each round. On some cards
this is hard or impossible to do. In those cases you can add this
constraint:

if ((err =3D snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PE=
RIODS)) < 0)
    return err;


--
Giuliano.


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job ea=
sier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronim=
o
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D=
121642
