From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: lib: Fix static linking of libasound
Date: Sun, 2 Jan 2011 00:42:23 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101020041250.28150@eeebox2.perex-int.cz>
References: <AANLkTi=BLZ-HFM4G6D6ZTLtUT5JCaXANS-hgVBC2SAXn@mail.gmail.com>
	<alpine.LNX.2.00.1101011604200.28150@eeebox2.perex-int.cz>
	<AANLkTinHXVVVykSh7uzCKNKv5NJsP5AVtj6-dDdzLDmb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 94E82243A7
	for <alsa-devel@alsa-project.org>; Sun,  2 Jan 2011 00:42:24 +0100 (CET)
In-Reply-To: <AANLkTinHXVVVykSh7uzCKNKv5NJsP5AVtj6-dDdzLDmb@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Chen <seven.steps@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 1 Jan 2011, Daniel Chen wrote:

> On Sat, Jan 1, 2011 at 10:07 AM, Jaroslav Kysela <perex@perex.cz> wrote:
>> Is any reason to ignore this configure settings mentined in the INSTALL file
>> for the static library build?
>>
>> ./configure --enable-shared=no --enable-static=yes
>>
>> It's mainly libtool issue and having static hacks in the dynamic library
>> does not make much sense.
>
> According to Samuel in the Debian bug report, "when both static &
> dynamic linking is enabled, automake gets it wrong and uses only the
> dynamic objects."
>
> Is the best course of action here to do a two-pass build, one with
> "--enable-shared=no --enable-static=yes" and another with
> "--enable-shared=yes --enable-static=no", simply copying the desired
> libasound.a from the second pass?

Yes, I believe, it's the right way to compile both types of library 
binaries.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
