From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: PCM rules for FireWave in speaker.c
Date: Fri, 28 Feb 2014 10:58:00 +0100
Message-ID: <53105DA8.1090607@ladisch.de>
References: <530FFF88.1040606@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 14E24264FBA
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 10:58:09 +0100 (CET)
In-Reply-To: <530FFF88.1040606@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Jay Fenlason <fenlason@redhat.com>
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> Current speaker.c have a rule for PCM channels/rates below:
>  - 6ch PCM at 32.0/44.1kHz
>  - 2ch PCM at 48.0/96.0kHz

The current rules in speakers.c disallow rates less than 48 kHz if there
are less than six channels, and disallow two channels if the rate is
less than 48 kHz.  This means that the allowed parameter combinations
are 2ch at 48/96 kHz, and 6ch at 32/44.1/48/96 kHz.

> Recently, with Jay Fenlason's help, I got some information about its
> stream format. I'll show them in the end of this message.
>
> As a result, I realized FireWave has stream formats below:
>  - 6ch PCM at 32.0/44.1/48.0/96.0kHz
>  - 2ch IEC 60958-3 at 32.0/44.1/48.0kHz
>
> Although there are no stream formats for 2ch PCM at 48.0/96.0kHz, the
> driver has it. Do you know the reason? Are there any model quirks?

I don't have any of the AV/C audio specifications; these rules were
determined experimentally.  In other words, when the sample rate is set
to 48 or 96 kHz, sending a stream with two PCM channels appears to work.

If you wanted to support these undocumented formats in your driver, you
would have to add some kind of quirk.


Regards,
Clemens
