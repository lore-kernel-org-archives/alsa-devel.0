From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v5 1/2] amidi: add delay option
Date: Mon, 22 Aug 2016 14:43:55 +0200
Message-ID: <5b064978-df48-23fa-26e1-89f9ed1843ff@ladisch.de>
References: <20160815163734.17658-1-eu@felipetonello.com>
 <20160815163734.17658-2-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 3B0BD26690F
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2016 14:44:11 +0200 (CEST)
In-Reply-To: <20160815163734.17658-2-eu@felipetonello.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Felipe F. Tonello" <eu@felipetonello.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Felipe F. Tonello wrote:
> +.I \-D, \-\-delay=3Dmseconds
> +Adds a delay in between each SysEx message sent to a device.

> +			while (data < (send_data + send_data_length)) {
> +				int len =3D send_data + send_data_length - data;
> +				char *temp;
> +
> +				if (data > send_data)
> +					usleep(delay * 1000);

The MIDI data is sent asynchonously, so this delay is not _between_ message=
s.
You'd have to add 320 =B5s for any byte not yet sent (I guess you have to u=
se
snd_rawmidi_status_get_avail() to find out how many have been sent).


> +				/* find end of SysEx */
> +				if ((temp =3D memchr(data, 0xf7, len)))

This would be clearer with "!=3D NULL".

> +					len =3D temp - data + 1;
> +
> +				if ((err =3D snd_rawmidi_write(output, data, len)) < 0) {
> +					error("cannot send data: %s", snd_strerror(err));
> +					return err;
> +				}
> +
> +				data +=3D len;
> +			}
>  		}
>  	}


Regards,
Clemens
