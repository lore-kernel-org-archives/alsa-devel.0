From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: skype and old alsa RC4 symbols
Date: Fri, 10 Apr 2009 12:13:07 -0400
Message-ID: <9e4733910904100913h8cd0466m21b3815030ad32fb@mail.gmail.com>
References: <9e4733910904081455u181eecebi31837f490cfd85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f132.google.com (mail-qy0-f132.google.com
	[209.85.221.132])
	by alsa0.perex.cz (Postfix) with ESMTP id CA6DD2440F
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Apr 2009 18:13:08 +0200 (CEST)
Received: by qyk38 with SMTP id 38so1921846qyk.16
	for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2009 09:13:08 -0700 (PDT)
In-Reply-To: <9e4733910904081455u181eecebi31837f490cfd85@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>, Luke Yelavich <luke@audioslack.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 8, 2009 at 5:55 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> I would like to run pulseaudio 9.15 contained in this ubuntu
> repository since it fixes my problems with S/PDIF
> https://launchpad.net/~themuso/+archive/ppa

I finally fixed this by hacking around to define -DUSE_VERSIONED_SYMBOLS.

Something is wrong in the build process for these packages.


>
> However, the 32b compatibility library in this build don't work with
> skype since it is missing some RC4 obsolete symbols.
>
> jonsmirl@terra:/home/apps/alsa-lib-1.0.19/debian/lib32asound2/usr/lib32$
> readelf -W -s libasound.so.2.0.0 | grep
> snd_pcm_hw_params_get_channels_min
> =A0 174: 0004a970 =A0 =A058 FUNC =A0 =A0WEAK =A0 DEFAULT =A0 12
> snd_pcm_hw_params_get_channels_min@@ALSA_0.9
> =A0 454: 0004a970 =A0 =A058 FUNC =A0 =A0GLOBAL DEFAULT =A0 12
> __snd_pcm_hw_params_get_channels_min@@ALSA_0.9
>
> The 64b library has the missing RC4 symbols.
>
> jonsmirl@terra:/home/apps/alsa-lib-1.0.19/debian/libasound2/usr/lib$
> readelf -W -s libasound.so.2.0.0 | grep
> snd_pcm_hw_params_get_channels_min
> =A0 173: 000000000004ff10 =A0 =A015 FUNC =A0 =A0GLOBAL DEFAULT =A0 12
> snd_pcm_hw_params_get_channels_min@@ALSA_0.9.0rc4
> =A0 177: 000000000004ff20 =A0 =A031 FUNC =A0 =A0GLOBAL DEFAULT =A0 12
> snd_pcm_hw_params_get_channels_min@ALSA_0.9
> =A0 462: 000000000004ff10 =A0 =A015 FUNC =A0 =A0GLOBAL DEFAULT =A0 12
> __snd_pcm_hw_params_get_channels_min@@ALSA_0.9
> jonsmirl@terra:/home/apps/alsa-lib-1.0.19/debian/libasound2/usr/lib$
>
> How do I get the RC4 symbols into the 32 library? I can pull down the
> source for this and build without problem. I just can't identify what
> needs to be changed to make the symbols appear in the 32b compat lib.
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>



-- =

Jon Smirl
jonsmirl@gmail.com
