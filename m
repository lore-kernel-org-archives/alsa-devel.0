From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch added to gregkh-2.6 tree
Date: Tue, 4 Apr 2006 16:23:43 -0400
Message-ID: <d120d5000604041323h448c1ccfi7e9dcedd82c385ba__45104.7110058882$1144183530$gmane$org@mail.gmail.com>
References: <44238489.8090402@keyaccess.nl> <1FQquz-2CO-00@press.kroah.org>
Reply-To: dtor_core@ameritech.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.235])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9907A222
	for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2006 22:23:44 +0200 (MEST)
Received: by wproxy.gmail.com with SMTP id 37so11352wra
        for <alsa-devel@alsa-project.org>; Tue, 04 Apr 2006 13:23:43 -0700 (PDT)
In-Reply-To: <1FQquz-2CO-00@press.kroah.org>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "gregkh@suse.de" <gregkh@suse.de>
Cc: rene.herman@keyaccess.nl, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On 4/4/06, gregkh@suse.de <gregkh@suse.de> wrote:
>
> --- gregkh-2.6.orig/drivers/base/bus.c
> +++ gregkh-2.6/drivers/base/bus.c
> @@ -372,14 +372,17 @@ int bus_add_device(struct device * dev)
>
>        if (bus) {
>                pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id=
);
> -               device_attach(dev);
> +               error =3D device_attach(dev);
> +               if (error < 0)
> +                       goto exit;

I do not believe that this is correct. The fact that _some_ driver
failed to attach to a device does not necessarily mean that device
itself does not exist. While this assuption might work for platform
devices it won't work for other busses.

As fasr as ALSA goes, if they want to abort loading module if device
is not present they will have to separate device probing from final
driver binding.

--
Dmitry


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
