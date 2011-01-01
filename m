From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: [PATCH] ALSA: lib: Fix static linking of libasound
Date: Sat, 1 Jan 2011 12:41:14 -0500
Message-ID: <AANLkTinHXVVVykSh7uzCKNKv5NJsP5AVtj6-dDdzLDmb@mail.gmail.com>
References: <AANLkTi=BLZ-HFM4G6D6ZTLtUT5JCaXANS-hgVBC2SAXn@mail.gmail.com>
	<alpine.LNX.2.00.1101011604200.28150@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E3F91037FF
	for <alsa-devel@alsa-project.org>; Sat,  1 Jan 2011 18:41:22 +0100 (CET)
Received: by wyi11 with SMTP id 11so12164492wyi.38
	for <alsa-devel@alsa-project.org>; Sat, 01 Jan 2011 09:41:16 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1101011604200.28150@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 1, 2011 at 10:07 AM, Jaroslav Kysela <perex@perex.cz> wrote:
> Is any reason to ignore this configure settings mentined in the INSTALL file
> for the static library build?
>
> ./configure --enable-shared=no --enable-static=yes
>
> It's mainly libtool issue and having static hacks in the dynamic library
> does not make much sense.

According to Samuel in the Debian bug report, "when both static &
dynamic linking is enabled, automake gets it wrong and uses only the
dynamic objects."

Is the best course of action here to do a two-pass build, one with
"--enable-shared=no --enable-static=yes" and another with
"--enable-shared=yes --enable-static=no", simply copying the desired
libasound.a from the second pass?

Thanks,
-Dan
