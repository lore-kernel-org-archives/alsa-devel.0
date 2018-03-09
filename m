From: Jorge Fernandez Monteagudo <jorgefm@cirsa.com>
Subject: Re: Cirrus CS4207 not working on 4.14.24
Date: Fri, 9 Mar 2018 15:00:28 +0000
Message-ID: <DB5PR0701MB20077AFBA816D6737BAB4416A1DE0@DB5PR0701MB2007.eurprd07.prod.outlook.com>
References: <DB5PR0701MB2007E6A97934EB7DC869DEA6A1DE0@DB5PR0701MB2007.eurprd07.prod.outlook.com>,
 <s5h8tb15mm0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10133.outbound.protection.outlook.com [40.107.1.133])
 by alsa0.perex.cz (Postfix) with ESMTP id BA882266E78
 for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2018 16:00:30 +0100 (CET)
In-Reply-To: <s5h8tb15mm0.wl-tiwai@suse.de>
Content-Language: es-ES
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Oh, thanks! That's really explain our behaviour...

I'll follow your instructions in order to disable the power_save_node

flag.


Thanks again!


________________________________
De: Takashi Iwai <tiwai@suse.de>
Enviado: viernes, 9 de marzo de 2018 15:50:47
Para: Jorge Fernandez Monteagudo
Cc: alsa-devel@alsa-project.org
Asunto: Re: [alsa-devel] Cirrus CS4207 not working on 4.14.24

On Fri, 09 Mar 2018 15:30:59 +0100,
Jorge Fernandez Monteagudo wrote:
>
> Oh, I know... That's not possible. It's a custom carrier and we only have connected
>
> the Line Out 1 (node 0x03, node 0x0A) and the S/PDIF Out 1 (node 0x08, node 0x10)
>
> to external devices.

Ah, that explains why the driver doesn't work.
As default, the driver does the dynamic codec power-down depending on
the jack detection.  And in your case, it's soldered.

That said, it's no real "bug" in the driver, but it's rather a special
use case.

As already mentioned, the power_save_node flag can be turned off via
codec hints.  You can write a codec "patch" file containing the lines
like the following:

[codec]
0x10134207 0x10134207 0
[hint]
power_save_node = no

and put it in e.g. /lib/firmware/alsa/cs4207-hack, and pass it via a
module option, e.g. add the following line

  options snd-hda-intel patch=,alsa/cs4207-hack

in any /etc/modprobe.d/*.conf file.
The comma (,) before "alsa/cs4207-hack" is no typo, it means to pass
to the secondary card.

The brief instruction is found in
Documentation/sound/hd-audio/notes.rst.


Takashi
