From: Jorge Fernandez Monteagudo <jorgefm@cirsa.com>
Subject: Re: Cirrus CS4207 not working on 4.14.24
Date: Fri, 9 Mar 2018 14:24:10 +0000
Message-ID: <DB5PR0701MB20073FB08658E720786A69D6A1DE0@DB5PR0701MB2007.eurprd07.prod.outlook.com>
References: <DB5PR0701MB2007E6A97934EB7DC869DEA6A1DE0@DB5PR0701MB2007.eurprd07.prod.outlook.com>,
 <s5hlgf15ra7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0115.outbound.protection.outlook.com [104.47.1.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F161266E78
 for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2018 15:24:14 +0100 (CET)
In-Reply-To: <s5hlgf15ra7.wl-tiwai@suse.de>
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

Sorry for the dumb question, but when you say "testing from the speaker" or "testing from the headphone"

it's enough using alsamixer to mute headphone or mute speaker and run an aplay when running alsa-info.sh?

________________________________
De: Takashi Iwai <tiwai@suse.de>
Enviado: viernes, 9 de marzo de 2018 14:09:52
Para: Jorge Fernandez Monteagudo
Cc: alsa-devel@alsa-project.org
Asunto: Re: [alsa-devel] Cirrus CS4207 not working on 4.14.24

On Fri, 09 Mar 2018 10:45:35 +0100,
Jorge Fernandez Monteagudo wrote:
>
> Hi!
>
>
> Your little patch works! I've attached the alsa-info for the 4.14.24 kernel once the
>
> system is running and no sound is available.
>
>
> The nodes are related to audio output. 0x03 DAC2 PCM linked to 0x0A: Line Out1
>
> I suspect nodes 0x09, 0x0A and 0x0B are not able to recover from D3 state.

That explains better.  But NID 0x0b has no power control, so it
shouldn't be affected by itself.  Rather NID 0x04 power-down can be
the issue, at least, for speaker outputs.  For the headphone, both NID
0x09 and 0x03 are used.

Please try the driver without the patch, and get alsa-info.sh output
while testing from the speaker, and while testing the headphone,
individually.  Attach both outputs for comparison.  Maybe better to
compressed, otherwise it becomes too long.


thanks,

Please
