From: William <walsac2@liam2.demon.co.uk>
Subject: Re: CVS ALSA failed upgrade in Linux 2.6.3
Date: Tue, 2 Mar 2004 17:28:18 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403021728.RAA18607@liam2.demon.co.uk>
References: <s5hvflndwyz.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hvflndwyz.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> wrote:
>> Thanks for explaining that.  Please would you delete the word "simply" in
>> the explanation on alsa-project.org because it's misleading.
>
>maybe better to remove the whole sentense.

I think it would be useful to keep an explanation of how to install
CVS alsa-kernel into a Linux 2.6.x source tree.

BTW, why is there still an alsa-driver package?
Is there any difference between (a) installing alsa-kernel into Linux 2.6.x
and (b) installing alsa-driver in the normal way with the configure option
--with-kernel=somewhere/linux

>the scripts directory shouldn't be copied.
>also, Documentation directory goes to linux/sound/Documentation/sound/alsa

Don't you mean "linux/sound/Documentation"?

>don't copy the files under oss directory.

So, perhaps below is a correct summary?

    cp -fR alsa-kernel/include/*  linux/include/sound
    mv -f alsa-kernel/include  out-of-the-way-temporarily-include

    mkdir -p linux/sound/Documentation/sound/alsa
    cp -fR alsa-kernel/Documentation/*  linux/sound/Documentation/sound/alsa
    mv -f alsa-kernel/Documentation out-of-the-way-temporarily-Documentation

    mv -f alsa-kernel/oss out-of-the-way-temporarily-oss

    mv -f alsa-kernel/scripts out-of-the-way-temporarily-scripts

    cp -fR alsa-kernel/*  linux/sound

Thanks,

William


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
