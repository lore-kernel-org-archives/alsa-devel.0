From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v2 1/2] amidi: add delay option
Date: Sat, 13 Aug 2016 13:51:05 +0200
Message-ID: <87767954-ce27-ac72-7b5e-4198213eb840@ladisch.de>
References: <20160812160435.27364-1-eu@felipetonello.com>
 <20160812160435.27364-2-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 03444265AED
 for <alsa-devel@alsa-project.org>; Sat, 13 Aug 2016 13:52:43 +0200 (CEST)
In-Reply-To: <20160812160435.27364-2-eu@felipetonello.com>
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
> This patch adds a new options to amidi tool to add a delay (in milliseconds)
> to each MIDI message.
     ^^^^
Not anymore.

> +		if (!delay) {
> +				if ((err = snd_rawmidi_write(output, send_data, send_data_length)) < 0) {
> +					error("cannot send data: %s", snd_strerror(err));
> +					return err;
> +				}
> +		} else {

Too much indentation.

> +				/* find beginning of SysEx and its end */
> +				while((unsigned char)data[len] != 0xf0 &&
> +				      (data + len) < (send_data + send_data_length))
> +					len++;
> +
> +				while((unsigned char)data[len] != 0xf7 &&
> +				      (data + len) < (send_data + send_data_length))
> +					len++;
> +				len++;

It is not necessary to search for both beginning and end.

And the search can be simplified with memchr().


Regards,
Clemens
