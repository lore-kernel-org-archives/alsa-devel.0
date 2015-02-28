From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: Issues and/or possible bugs in alsa
Date: Sat, 28 Feb 2015 18:22:19 +0500
Message-ID: <54F1C10B.2050008@gmail.com>
References: <CACui-2k8j3ZWtmvwiE3V5apuQ0g-dn=wN-h4miExDYLLR4diWA@mail.gmail.com>	<54ED8466.7020102@gmail.com>
 <CAN8cciYnyLahS2gQ0g0vSaNj+xo=Tz9_FQ9L-WazOb1t5no_kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f180.google.com (mail-we0-f180.google.com
 [74.125.82.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 29D20260451
 for <alsa-devel@alsa-project.org>; Sat, 28 Feb 2015 14:22:23 +0100 (CET)
Received: by wesp10 with SMTP id p10so23008008wes.12
 for <alsa-devel@alsa-project.org>; Sat, 28 Feb 2015 05:22:22 -0800 (PST)
In-Reply-To: <CAN8cciYnyLahS2gQ0g0vSaNj+xo=Tz9_FQ9L-WazOb1t5no_kA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

28.02.2015 15:00, Raymond Yau wrote:
>
> It is strange that your hdmi card have a softvol control ,
>
> Was  the softvol control created when you swap the card number by 
> index=1,0 ?
>

The control was created when I used a custom asoundrc in order to test 
dmix on top of hdmi. Since then, I removed the customization, but there 
is no easy way to remove the control, as it is always saved on shutdown 
and restored on boot even if there is nothing in the current .asoundrc 
that uses it. I will remove it from the state file using a livecd, just 
to avoid such questions in the future.

-- 
Alexander E. Patrakov
