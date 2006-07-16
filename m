From: Rene Rebe <rene@exactcode.de>
Subject: Re: ALSA Intel HDA MacBook
Date: Sun, 16 Jul 2006 17:37:42 +0200
Message-ID: <200607161737.43160.rene@exactcode.de>
References: <200607081323.17265.rene@exactcode.de> <44B24168.10405@boichat.ch>
	<s5hk66k76sh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hk66k76sh.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Matt Porter <mporter@embeddedalley.com>, alsa-devel@lists.sourceforge.net, Nicolas Boichat <nicolas@boichat.ch>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

as usually i was a bit busy the last days but gave this patch
(ported to 2.6.17) a try:

On Tuesday 11 July 2006 12:52, Takashi Iwai wrote:

> diff --git a/sound/pci/hda/patch_sigmatel.c
> b/sound/pci/hda/patch_sigmatel.c index fb4bed0..ea99083 100644
> --- a/sound/pci/hda/patch_sigmatel.c
> +++ b/sound/pci/hda/patch_sigmatel.c
> @@ -351,6 +351,7 @@ static unsigned int *stac922x_brd_tbl[ST
>  	[STAC_REF] =3D	ref922x_pin_configs,
>  	[STAC_D945GTP3] =3D d945gtp3_pin_configs,
>  	[STAC_D945GTP5] =3D d945gtp5_pin_configs,
> +	[STAC_MACMINI] =3D d945gtp5_pin_configs,
>  	[STAC_D965_2112] =3D d965_2112_pin_configs,
>  };

Well, this results in quite a different mixer configuration, that might be
a bit more logical - but still a bit cumbersome to use:

- I have no headphone mixer, plugging the headphone in mutes the
  speakers and only drives the headphone, good

- the line in as Line In as Output switch enables the stereo side speakers

- the side speakers are controlled by a Side mixer element

- the center keyboard speaker is controlled by the Front mixer,
  this element also controls the headphone when plugged in

So far so good, however slightly annoying is that I need to manually
move to slider around to control the speaker ambient sound. Maybe
we ca do something about that?

-- =

Ren=E9 Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://exactcode.de | http://t2-project.org | http://rebe.name
            +49 (0)30 / 255 897 45


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
