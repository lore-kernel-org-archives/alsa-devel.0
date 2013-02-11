From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HD-audio generic parser merged to linux-next
Date: Mon, 11 Feb 2013 22:20:15 +0800
Message-ID: <CAN8ccia4vHek6n5xZi26nNZV0wmzv3H6cBjP4q+UTi3ubyTHSw@mail.gmail.com>
References: <s5hbocg1etr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f174.google.com (mail-ia0-f174.google.com
 [209.85.210.174])
 by alsa0.perex.cz (Postfix) with ESMTP id BB99D2602AD
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2013 15:20:16 +0100 (CET)
Received: by mail-ia0-f174.google.com with SMTP id o25so6460260iad.33
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2013 06:20:15 -0800 (PST)
In-Reply-To: <s5hbocg1etr.wl%tiwai@suse.de>
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

>
> If you encounter any regression by the recent update, please let me
> know.
>

Refer to commit 657e1b931d42882cb0a59b599247bef696c22406

ALSA: hda - Select auto-parser as default for AD codecs

it seem that independent hp is enabled on AD1986A which does not support
indepedent headphone

Attach PCM dev 0, name AD1986A Analog, type audio, play #1, capture #1
send: NID=0x2, VERB=0xf00(get_parameters), PARM=0xa(PCM)
receive: 0x20060
send: NID=0x2, VERB=0xf00(get_parameters), PARM=0xb(stream)
receive: 0x5
Attach PCM dev 1, name AD1986A Digital, type SPDIF, play #1, capture #0
send: NID=0x1, VERB=0xf00(get_parameters), PARM=0xa(PCM)
receive: 0xe007f
send: NID=0x5, VERB=0xf00(get_parameters), PARM=0xb(stream)
receive: 0x0
send: NID=0x1, VERB=0xf00(get_parameters), PARM=0xb(stream)
receive: 0x1
Attach PCM dev 2, name AD1986A Alt Analog, type audio, play #1, capture #0
# Init and building controls...
