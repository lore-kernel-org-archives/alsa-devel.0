From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: No device for DAI omap-eac-dai error
Date: Mon, 21 Dec 2009 08:42:37 +0200
Message-ID: <200912210842.37511.peter.ujfalusi@nokia.com>
References: <e7c6a05e0912180618h771b9b7fl9d197d500bc534c1@mail.gmail.com>
	<e7c6a05e0912190851q273555beg2f1ed415a8c9399f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 92EF210384D
	for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2009 07:42:44 +0100 (CET)
In-Reply-To: <e7c6a05e0912190851q273555beg2f1ed415a8c9399f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: ext Belisko Marek <marek.belisko@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello,

On Saturday 19 December 2009 18:51:59 ext Belisko Marek wrote:
> Hi,
> =

> I'm writing new omap dai (for EAC codec base omap's).
> My code is based on existing omap-mcbsp.c code basically.
> =

> After loadingof module I got error which appear in init function when
> call snd_soc_register_dai().

It is a warning about the missing dai->dev, if the McBSP dais are in use yo=
u get =

the same warning for all the ports.
AFAIK at the moment it is harmless.
 =

> I browse for code but can't figure out where dai->dev should be set to
> don't get error message and init dai properly.
> =

> Thanks for any suggestions
> =

> Marek
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> =


-- =

P=E9ter
