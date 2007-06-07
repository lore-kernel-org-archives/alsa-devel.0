From: dustin@seznam.cz
Subject: Re: EMU 1212 - 16 capture channels - patch
Date: Thu, 07 Jun 2007 11:08:22 +0200 (CEST)
Message-ID: <10237.26199-15888-824652669-1181207302@seznam.cz>
References: <s5h7iqjc1ko.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxl.seznam.cz (mxhn.seznam.cz [212.80.76.26])
	by alsa0.perex.cz (Postfix) with SMTP id CEE1424572
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2007 11:08:26 +0200 (CEST)
In-Reply-To: <s5h7iqjc1ko.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?us-ascii?Q?Takashi=20Iwai?= <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi, =


Thanks a lot, and sorry for the coding style.

Pavel.
>  ------------ P=F9vodn=ED zpr=E1va ------------
>  Od: Takashi Iwai <tiwai@suse.de>
>  P=F8edm=ECt: Re: EMU 1212 - 16 capture channels - patch
>  Datum: 04.6.2007 15:05:46
>  ----------------------------------------
>  At Thu, 31 May 2007 23:10:22 +0200 (CEST),
>  dustin@seznam.cz wrote:
>  > =

>  > Hello,
>  > =

>  > Here is the patch increasing number of capture channels from 8 to 16. =
In this
>  patch the unused PCMs are not removed yet, I have not been able to test
>  thoroughly to confirm they are 100% sure useless.
>  > =

>  > As a next project, I would like to try to raise playback resolution fr=
om the
>  current 16bits to 24 (32) bits, using audigy DSP instructions, inversion=
 of the
>  convert32to2x16 function. I would really appreciate comments and suggest=
ions
>  from experts on this card regarding feasibility and possible caveats.
>  > =

>  > Patch description:
>  > =

>  > * adding 8 more 32-bit capture channels (total of 16) for emu1010 cards
>  > * adding some code comments and card details description
>  > =

>  > Signed-off-by: Pavel Hofman <dustin@seznam.cz>
>  =

>  Thanks for the patch.  The changes appear OK (as I have no hardware
>  for testing), but please try to follow the standard coding style.
>  Namely,
>  =

>  - don't put space after '('
>  - keep 80 chars in a line (including comments)
>    fold lines appropriately
>  - don't put braces { } for a single if-else command
>  =

>  Anyway, the patch will be merged after 1.0.14, so don't worry about
>  the delay :)
>  =

>  =

>  Takashi
>  =

>  =

>  =
