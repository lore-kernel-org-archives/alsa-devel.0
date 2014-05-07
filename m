From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH]: snd_seq_virmidi.c do not use running
 status for virmidi raw input
Date: Wed, 07 May 2014 22:41:20 +0200
Message-ID: <536A9A70.4020401@ladisch.de>
References: <536A7104.7010009@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id D9B8826532C
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 22:41:39 +0200 (CEST)
In-Reply-To: <536A7104.7010009@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ralfbeck1@gmx.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ralf Beck wrote:
> Rationale: Not every rawmidi alsa client (e.q. Bitwig) support running status on input.

Why does Bitwig use RawMIDI when it is only interested in the events?

Anyway, running status is part of the MIDI protocol.
This is a bug in Bitwig.

And changing this setting might introduce regressions in other programs
that rely on the size of the raw MIDI data.

> +        vmidi->parser->nostat = 1;
>      vmidi->seq_mode = rdev->seq_mode;

The patch formatting is still broken.

And please read Documentation/SubmittingPatches,


Regards,
Clemens
