From: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 2/2] usbtv: add audio support
Date: Sun, 05 Jan 2014 17:43:52 +0100
Message-ID: <1388940232.16586.8.camel@odvarok.lan>
References: <1388936292-8974-1-git-send-email-fsimonce@redhat.com>
 <1388936292-8974-2-git-send-email-fsimonce@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from shell.v3.sk (shell.v3.sk [195.168.3.45])
 by alsa0.perex.cz (Postfix) with ESMTP id CD68626109C
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2014 17:44:10 +0100 (CET)
In-Reply-To: <1388936292-8974-2-git-send-email-fsimonce@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Federico Simoncelli <federico.simoncelli@gmail.com>
Cc: alsa-devel@alsa-project.org, Federico Simoncelli <fsimonce@redhat.com>
List-Id: alsa-devel@alsa-project.org

On Sun, 2014-01-05 at 16:38 +0100, Federico Simoncelli wrote:
...
> +	static const u16 setup[][2] = {
> +/*		{ USBTV_BASE + 0x00a2, 0x0013 }, */

A minor style issue here, please avoid useless comments.


> +	strncpy(card->driver, usbtv->dev->driver->name,
> +		sizeof(card->driver) - 1);
> +	strncpy(card->shortname, "usbtv", sizeof(card->shortname) - 1);

I suggest you use the strlcpy() instead, as is used in the rest of the
driver. Aside from that it is more consistent, it would make it a bit
easier to verify that the string is properly terminated without having
to take a look at snd_card_create() to see whether zeroes out the
structure for you.

> +	strncpy(pcm->name, "USBTV Audio Input", sizeof(pcm->name) - 1);

Ditto.

Thank you!
Lubo
