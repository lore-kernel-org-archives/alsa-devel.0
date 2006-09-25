From: "Marc Brooker" <marcbrooker@gmail.com>
Subject: Re: [Alsa-user] USB card @48kHz only: at what layer to
	resample?
Date: Mon, 25 Sep 2006 08:35:04 +0200
Message-ID: <b5ee41f40609242335v4cb0c8b2w6748bff74b3242f4@mail.gmail.com>
References: <J63PIH$040EF5CF6AFFDBCB31B65DEC3272A191@libero.it>
	<Pine.LNX.4.61.0609240755230.27883@info.physics.ubc.ca>
	<20060924182825.2230a6bf@comp.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060924182825.2230a6bf@comp.home.net>
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 9/24/06, Sergei Steshenko <steshenko_sergei@list.ru> wrote:
>
> Takashi Iwai meant to include quality resampler into ALSA - I do not know
> what the status is.

The resample plugin, written by Takashi Iwai, enables high quality
resampling in ALSA. You need to install the plugin (it's included in
the 1.0.11 and higher source, but most distros don't package it yet)
and add a line to either alsa.conf or .asoundrc enabling it.

Takashi's plugin (which uses libsamplerate) performs very well,
especially when compared to the standard rate converter included in
ALSA. I would recommend it if you are doing any sort of resampling
operation.

In my opinion, it should be enabled by default, but that's a different
argument for a different day.
>
> A LADSPA plugin can be created for the purpose.
>
> Anyway, there are good quality resamplers, and they consume less than 5% =
CPU
> even on old CPUs.
>
> --Sergei.
>
> --
> Visit my http://appsfromscratch.berlios.de/ open source project.
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>


-- =

Increasingly, people seem to misinterpret complexity as
sophistication, which is baffling =97 the incomprehensible should cause
suspicion rather than admiration - Niklaus Wirth

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
