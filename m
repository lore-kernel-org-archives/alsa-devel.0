From: =?ISO-8859-1?Q?Jean-Pierre_Andr=E9?= <jean-pierre.andre@wanadoo.fr>
Subject: Re: [Fwd: HP DV4 1155 SE - No Sound through
	speakers...]
Date: Wed, 04 Feb 2009 18:37:02 +0100
Message-ID: <4989D23E.2070601@wanadoo.fr>
References: <4983FE7A.1040201@wanadoo.fr>	<49840333.2080303@wanadoo.fr>	<200902021620.52104.herton@mandriva.com.br>	<49884B73.7050906@wanadoo.fr>	<4989C9E6.7070902@wanadoo.fr>
	<s5h1vue86ys.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp19.orange.fr (smtp19.orange.fr [80.12.242.1])
	by alsa0.perex.cz (Postfix) with ESMTP id A87D51037FC
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 18:37:04 +0100 (CET)
In-Reply-To: <s5h1vue86ys.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, tim.barnette@gmail.com, Herton Ronaldo Krzesinski <herton@mandriva.com.br>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Takashi Iwai wrote:
> At Wed, 04 Feb 2009 18:01:26 +0100,
> Jean-Pierre Andr=E9 wrote:
>   =

>> On my computer, the main problem is an IRQ one, which I knew you did
>> not address, but I still wanted to know if something would improve
>> (see below)
>>     =

>
> You can pass enable_msi=3D1 option instead of patching hda_intel.c.
> If it doesn't solve the IRQ problem, it must be in a pretty deep level.
>   =


Maybe. I just applied the suggested patches, and I was
using the option enable_msi=3D1. This could be redundant.

> This was tested on a HP dv4-1115ef, with a sound device identified as :
>
> Codec: IDT 92HD71B7X
> Codec: Generic 10de ID 3
>   =

>
> Hm, you didn't set CONFIG_SND_HDA_CODEC_NVHDMI=3Dy?
>   =


Good catch. I am using a standard Fedora 10 distribution,
and I do not see the above in the .config

Are you telling me I have to recompile the kernel ? and
with an option "y" (not "m") will I have to recompile for
every ALSA release ?

Regards

Jean-Pierre
