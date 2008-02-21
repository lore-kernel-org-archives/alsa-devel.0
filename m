From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] alsa-lib: issues in snd_seq_change_bit and
 some enhancements
Date: Thu, 21 Feb 2008 08:59:29 +0100
Message-ID: <47BD2F61.7070103@ladisch.de>
References: <1203577712.13752.33.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id E94AB2438D
	for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2008 08:57:49 +0100 (CET)
In-Reply-To: <1203577712.13752.33.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Aldrin Martoq <amartoq@dcc.uchile.cl>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Aldrin Martoq wrote:
> 1) snd_seq_change_bit is not working as expected.

Indeed.

> 2) There is no sane way to clear the event_filter of
> snd_seq_client_info_t structure. Because the structure is opaque, we
> cannot memset to zero because the user doesn't know the size of the
> bitmap.

The event type is an 8-bit quantity; this is part of the sequencer API.
The bitmap has exactly 256 bits, i.e., 32 bytes.

It would be nice if this were actually documented ...


Regards,
Clemens
