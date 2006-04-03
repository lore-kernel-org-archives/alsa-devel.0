From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: About the data word format of PCM
Date: Mon, 03 Apr 2006 09:36:19 +0200 (CEST)
Message-ID: <XFMail.20060403093619.pochini@shiny.it>
References: <715d90900604022301k408a8a35ib89ea5dd7d58e706@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <715d90900604022301k408a8a35ib89ea5dd7d58e706@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: boku <boku0712@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 03-Apr-2006 boku wrote:

> How is the arrangement in one 32-bit word for either Stereo,
> SNDRV_PCM_FMTBIT_S16_LE

This is 16 bits. There is no 16bits data in 32bits format AFAIK.


> or SNDRV_PCM_FMTBIT_S24_LE?

This is 24bits right aligned in 32bits, that is XXXXX:bits0-7:bits8-15:bi=
ts16-23


> And is there any way to
> change such as Left and right channel's bit position or the signed bit =
if
> necessary? Thanks a lot!~

Change what ?  The format depends on the card.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting langua=
ge
that extends applications into web and mobile media. Attend the live webc=
ast
and join the prime developer group breaking into this new coding territor=
y!
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=3D=
121642
