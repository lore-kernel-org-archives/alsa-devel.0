From: dustin@seznam.cz
Subject: Re: ICE1724 alsa driver
Date: Wed, 23 May 2007 16:21:19 +0200 (CEST)
Message-ID: <9723.25499-31972-2031248606-1179930079@seznam.cz>
References: <loom.20070522T233114-523@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxl.seznam.cz (mxhn.seznam.cz [212.80.76.26])
	by alsa0.perex.cz (Postfix) with SMTP id D564F2462B
	for <alsa-devel@alsa-project.org>;
	Wed, 23 May 2007 16:21:20 +0200 (CEST)
In-Reply-To: <loom.20070522T233114-523@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rossco <r.maclachlan@strath.ac.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Ross,

what kind of SPDIF receiver the HV-7.1CH Hitpoint card uses? =


http://www.hitpoint.com.tw/computer/en/product/soundcard/via/hv-71ch.htm

I guess it is the chip right next to the two TOSLINK connectors. If it is C=
S8415 (looks similar), support for this chip could be taken from aureon.c, =
or perhaps the whole aureon code would fit this card better than the amp.c =
code with Chaintec AV710.

Regards,


Pavel.
>  ------------ P=F9vodn=ED zpr=E1va ------------
>  Od: Rossco <r.maclachlan@strath.ac.uk>
>  P=F8edm=ECt: Re: [alsa-devel] ICE1724 alsa driver
>  Datum: 22.5.2007 23:36:51
>  ----------------------------------------
>  =

>  Hi,
>  =

>  I have been a little hasty about posting about routing to the vt1616 cha=
nnels -
>  think I will now be able to achieve what I am after with alsa's route pl=
ugin.
>  =

>  However, I am still keen to enable spdif in within a driver that usually=
 does
>  not support such a feature. Would be grateful for any discussion of how =
this
>  could be implemented.
>  =

>  Cheers,
>  =

>  Ross
>  =

>  =

>  =

>  _______________________________________________
>  Alsa-devel mailing list
>  Alsa-devel@alsa-project.org
>  http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>  =

>  =

>  =
