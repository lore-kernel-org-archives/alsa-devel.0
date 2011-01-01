From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: lib: Fix static linking of libasound
Date: Sat, 1 Jan 2011 16:07:23 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101011604200.28150@eeebox2.perex-int.cz>
References: <AANLkTi=BLZ-HFM4G6D6ZTLtUT5JCaXANS-hgVBC2SAXn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 42DE51037EA
	for <alsa-devel@alsa-project.org>; Sat,  1 Jan 2011 16:07:24 +0100 (CET)
In-Reply-To: <AANLkTi=BLZ-HFM4G6D6ZTLtUT5JCaXANS-hgVBC2SAXn@mail.gmail.com>
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

On Tue, 28 Dec 2010, Daniel Chen wrote:

> Hi,
>
> Attached is a patch from Samuel Thibault that fixes static linking of
> libasound.a (forwarded from Debian bug report #522544).

Is any reason to ignore this configure settings mentined in the INSTALL 
file for the static library build?

./configure --enable-shared=no --enable-static=yes

It's mainly libtool issue and having static hacks in the dynamic library 
does not make much sense.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
