From: Guilherme <grlongo.ireland@gmail.com>
Subject: Re: sound device is buzy to run pcm.c
Date: Wed, 17 Jun 2009 11:59:11 -0300
Message-ID: <4A3904BF.5090101@gmail.com>
References: <fa40cc720906142011s5c2547e9r33a484a554a89fae@mail.gmail.com>
	<75b66ecd0906161944q40f471fdiae23c3290c866e85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A107103853
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Jun 2009 16:58:58 +0200 (CEST)
Received: by qyk1 with SMTP id 1so458534qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2009 07:58:56 -0700 (PDT)
In-Reply-To: <75b66ecd0906161944q40f471fdiae23c3290c866e85@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lee Revell <rlrevell@joe-job.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lee, I noticed that and I killed the process.

After I have it killed, the program gimme segfault.....!

;O( Ill check it in another machine to see what happens!

Tks!

-------------------

Guilherme Longo
Dept. Eng. da Computa=E7=E3o
Unaerp

Linux User - #484927

*Before Asking
http://www.istf.com.br/?page=3Dperguntas

!- I'd rather die on my feet than live on my knees -!



Lee Revell wrote:
> On Sun, Jun 14, 2009 at 11:11 PM, Guilherme Raymo
> Longo<grlongo.ireland@gmail.com> wrote:
>   =

>> I tried to check if the device is really buzy:
>>
>> root@lap:/home/guilherme/Experimentos# lsof |grep snd
>> lsof: WARNING: can't stat() fuse.gvfs-fuse-daemon file system */
>> home/guilherme/*.gvfs
>>     Output information may be incomplete.
>> esd       5433  guilherme  mem       CHR     116,16                6947
>> /dev/snd/pcmC0D0p
>> esd       5433  guilherme    5r          CHR     116,33                6=
787
>> /dev/snd/timer
>> esd       5433  guilherme    6w        CHR     116,16                6947
>> /dev/snd/pcmC0D0p
>> esd       5433  guilherme    7r         CHR      116,0                  =
6987
>> /dev/snd/controlC0
>>
>> and it seems to be ok.
>>     =

>
> Of course it's busy, esd has it open.
>
> Lee
>
>   =
