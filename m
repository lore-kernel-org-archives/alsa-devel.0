From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [PATCH] echoaudio, fw_writer
Date: Sun, 23 Jul 2006 17:26:47 +0200
Message-ID: <20060723172647.4f7a8c25.pochini@shiny.it>
References: <XFMail.20060719103126.pochini@shiny.it>
	<200607201126.29627.linux@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200607201126.29627.linux@blennerhassett.gen.nz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Eliot Blennerhassett <linux@blennerhassett.gen.nz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 20 Jul 2006 11:26:29 +1200
Eliot Blennerhassett <linux@blennerhassett.gen.nz> wrote:

> On Wed, 19 Jul 2006 20:31, Giuliano Pochini wrote:
>
> > I do not completely agree with that, but this patch solves the
> > issue (and fw_loader.c is 200 bytes shorter 8D).
>
> Now you don't have to include each C file, you could make fw_loader.c int=
o =

> universal c to fw converter by getting the parameters for
>
> +=A0=A0=A0=A0=A0=A0=A0write_fw("loader_dsp.fw", "DSP/LoaderDSP.c");
>
> from the commandline?
>
> Making it easier to build just one firmware, or a new firmware without =

> updating firmware.c. And making the program shorter too...

Sure. It is useful for the emu driver other than mine.


--
Giuliano.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
