From: Rene Rebe <rene.rebe@gmx.net>
Subject: Re: problem with versioned symbols and shared
 libraries
Date: Sat, 17 Jan 2004 12:34:23 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040117.123423.466663026.rene.rebe@gmx.net>
References: <20040116.200200.971177181.rene.rebe@gmx.net>
	<Pine.LNX.4.58.0401171211090.1879@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0401171211090.1879@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@lists.sourceforge.net, ziegler@informatik.hu-berlin.de
List-Id: alsa-devel@alsa-project.org

Hi,

On: Sat, 17 Jan 2004 12:18:07 +0100 (CET),
    Jaroslav Kysela <perex@suse.cz> wrote:

> > rene@idefix:~/develop/trunk/lowlevel/src$ g++ --shared -g -Wall -I.=

> > -I../include -I../../dam/include -I../../utility/include -o
> > ALSAHelper.so ALSAHelper.cc
> =

> I tried that and it seems that you MUST link also this shared module =

> against the asound library:
> =

> g++ --shared -g -Wall -I. -I../include -I../../dam/include
> -I../../utility/include -lasound -o ALSAHelper.so ALSAHelper.cc
>                         ^^^^^^^^
> =

> Otherwise the versioned symbol are not applied. Here is the correct n=
m =

> output:
> =

> perex@pnote:~/src/1/svn.rocklinux-consulting.de/gsmp/trunk/lowlevel/s=
rc> =

> nm ALSAHelper.so  | grep snd_pcm_hw_params_get_channels_max
>          U snd_pcm_hw_params_get_channels_max@@ALSA_0.9.0rc4
> =

> 					Have fun,
> 						Jaroslav

Ineed that did the trick! Thank you!

Have a nice weekend,
  Ren=E9 Rebe

--  =

Ren=E9 Rebe - Europe/Germany/Berlin
  rene@rocklinux.org rene@rocklinux-consulting.de
http://www.rocklinux.org http://www.rocklinux-consulting.de
http://gsmp.tfh-berlin.de/gsmp http://gsmp.tfh-berlin.de/rene



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
