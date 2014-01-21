From: Russ Whitaker <russ@ashlandhome.net>
Subject: Re: HD audio problem (fwd)
Date: Tue, 21 Jan 2014 15:04:13 -0800 (PST)
Message-ID: <alpine.LNX.2.11.1401211457380.1733@red.russwhit.org>
References: <alpine.LNX.2.11.1401112322040.26152@red.russwhit.org>
 <s5h1u0cw64h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from red.russwhit.org (unknown [66.241.84.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 50470261A80
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 00:04:02 +0100 (CET)
In-Reply-To: <s5h1u0cw64h.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On Mon, 13 Jan 2014, Takashi Iwai wrote:

> At Sat, 11 Jan 2014 23:24:44 -0800 (PST),
> Russ Whitaker wrote:
>>
>>
>> Still not heard from you. WHY?
>
> Maybe there is an easy and obvious solution like using PulseAudio :)
> Alternative is to pass index=1,0 option to snd-hda-intel module.

Thank you, that worked:

In rc.udev, just before starting udev, I put this line:
   /sbin/modprobe snd-hda-intel index=1,0

Russ
>
>
> Takashi
>
