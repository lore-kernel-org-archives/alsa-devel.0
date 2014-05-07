From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] rawmidi.c Set a name for a newly allocated
 rawmidi substream
Date: Wed, 07 May 2014 19:39:46 +0200
Message-ID: <536A6FE2.20109@ladisch.de>
References: <536A6C3D.6080906@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 14746265253
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 19:40:08 +0200 (CEST)
In-Reply-To: <536A6C3D.6080906@gmx.de>
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
> Rationale: Bitwig Studio (and possibly other rawmidi clients) enumerate the Midi I/Os by
> substream names. With the current rawmidi implementation, the name is an empty string
> and only the USB mididriver changes it to a meaningful value after allocation.

Many RawMIDI devices have only one substream, or multiple substreams that are
merged into one port.  For these, separate substream names do not make sense.

> This patch sets a default substream name of the form "somename x-y-z"

The ID string is not meant to be a name.


Also see Documentation/SubmittingPatches.

> @@ -1420,6 +1421,8 @@ static int snd_rawmidi_alloc_substreams(
>          substream->number = idx;
>          substream->rmidi = rmidi;
>          substream->pstr = stream;
> +            snprintf(substream->name, sizeof(substream->name),

Your mailer broke whitespaces.


Regards,
Clemens
