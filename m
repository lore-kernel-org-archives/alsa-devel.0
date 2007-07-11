From: dustin@seznam.cz
Subject: Re: Query regarding sampling rates etc
Date: Wed, 11 Jul 2007 09:58:01 +0200 (CEST)
Message-ID: <11054.27185-13613-1900930647-1184140681@seznam.cz>
References: <1184102288.3301.56.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpi.seznam.cz (smtpic.seznam.cz [194.228.103.97])
	by alsa0.perex.cz (Postfix) with SMTP id D813B1038E0
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jul 2007 09:58:04 +0200 (CEST)
In-Reply-To: <1184102288.3301.56.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pharaoh <pharaoh137@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Exactly, this sounds like when I was sending left-aligned serial audio inst=
ead of I2S format from ice1724 to the codec. Low volumes were OK, higner di=
storted.

Pavel.

>  ------------ P=F9vodn=ED zpr=E1va ------------
>  Od: Liam Girdwood <lg@opensource.wolfsonmicro.com>
>  P=F8edm=ECt: Re: [alsa-devel] Query regarding sampling rates etc
>  Datum: 10.7.2007 23:18:21
>  ----------------------------------------
>  On Tue, 2007-07-10 at 19:32 +0530, Pharaoh . wrote:
>  > Hi,
>  > This is a very vague question, just thought of asking it after hours of
>  > debugging.
>  > =

>  > I am testing my alsa driver, written for omap 730/850 based board. I am
>  > testing it by using aplay.
>  > =

>  > Despite checking clocks, sampling rates etc many times and after doing=
 many
>  > combinations thereof, I cant hear anything more than a noise which cha=
nges
>  > and becomes more like the original .wav file as I change various param=
s like
>  > sampling rates/clocks etc. It becomes close to the actual thing, but n=
ot
>  > better.
>  > =

>  > Any idea what are the params I should be tweaking? I know this is h/w
>  > dependent.
>  > =

>  =

>  Sounds like (no pun intended) your digital audio interface is not set up
>  correctly between your codec and CPU.  It's probably best to make sure
>  they are both using the same I2S or PCM modes.
>  =

>  Liam  =

>  =

>  _______________________________________________
>  Alsa-devel mailing list
>  Alsa-devel@alsa-project.org
>  http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>  =

>  =

>  =
