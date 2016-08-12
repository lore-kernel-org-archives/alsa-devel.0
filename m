From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] amidi: add delay option
Date: Fri, 12 Aug 2016 09:10:17 +0200
Message-ID: <9210b56c-04ec-70c7-dc66-0478f13636d1@ladisch.de>
References: <20160811163106.15063-1-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 149DF266C29
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 09:10:20 +0200 (CEST)
In-Reply-To: <20160811163106.15063-1-eu@felipetonello.com>
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
>
> This is very useful when sending firmware updates to a remote device via SysEx
> or any other use that requires this delay in between messages.

> +	case 0xf4:
> +	case 0xf5:
> +		return 0; /* ignore */
> +	case 0xf7:
> +		return 0; /* ignore */

Silent data loss is bad.

> +	case 0x00 ... 0x7f:
> +		return rstate_len ?: rstate_len - 1;

rstate_len - 1 == -1

> +				int len = message_length(*data);
> +
> +				/* check for variable length */
> +				if (len == -1) {
> +					int i = 0;
> +					while (data[i++] != 0xf7);

Possible buffer overflow.

> +				if (len > 0 &&
> +				    (err = snd_rawmidi_write(output, data, len)) < 0) {

Same here.


The most robust way to find message boundaries probably would be a state
machine.  However, there is actually no requirement to find all message
boundaries; the _actual_ requirement is to insert pauses between SysEx
messages.  So don't bother to try to parse everything; just search for
F0 or F7.


Regards,
Clemens
