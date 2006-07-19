From: Eliot Blennerhassett <linux@blennerhassett.gen.nz>
Subject: Re: [PATCH] echoaudio, fw_writer
Date: Thu, 20 Jul 2006 11:26:29 +1200
Message-ID: <200607201126.29627.linux@blennerhassett.gen.nz>
References: <XFMail.20060719103126.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <XFMail.20060719103126.pochini@shiny.it>
Content-Disposition: inline
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
Cc: Giuliano Pochini <pochini@shiny.it>
List-Id: alsa-devel@alsa-project.org

On Wed, 19 Jul 2006 20:31, Giuliano Pochini wrote:

> I do not completely agree with that, but this patch solves the
> issue (and fw_loader.c is 200 bytes shorter 8D).

Now you don't have to include each C file, you could make fw_loader.c into =

universal c to fw converter by getting the parameters for

+=A0=A0=A0=A0=A0=A0=A0write_fw("loader_dsp.fw", "DSP/LoaderDSP.c");

from the commandline?

Making it easier to build just one firmware, or a new firmware without =

updating firmware.c. And making the program shorter too...

Script or makefile executes
# fw_writer DSP/LoaderDSP.c loader_dsp.fw

-- Eliot

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
