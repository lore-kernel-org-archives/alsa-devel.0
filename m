From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: 7.1 surround not working on ALC892/ Ubuntu 13.04
Date: Sun, 2 Mar 2014 12:04:35 +0800
Message-ID: <CAN8ccibQ6msuO1M9W=+7uYSF=FAabegNwFPb4+yPrn0PAqAWxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f172.google.com (mail-qc0-f172.google.com
 [209.85.216.172])
 by alsa0.perex.cz (Postfix) with ESMTP id EB6BD260816
 for <alsa-devel@alsa-project.org>; Sun,  2 Mar 2014 05:04:36 +0100 (CET)
Received: by mail-qc0-f172.google.com with SMTP id i8so2477089qcq.17
 for <alsa-devel@alsa-project.org>; Sat, 01 Mar 2014 20:04:36 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Subodh Chiwate <subodh.austin@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> I am unable to get 7.1 surround sound option on my system.
> Alsamixer is not giving me any option to choose 8 channels.
> Surround 5.1 is working correctly.
> I am not sure how to configure the system to get the 8 channel setup
working.
>
 >Distributor ID: Ubuntu
>Description: Ubuntu 13.04
>Release: 13.04
>Codename: raring

>Attaching all the sound-card information I could gather from the system.
>Please let me know in case any additional information is needed to debug
the issue.

> user1 <at> user1-MI970VF:~/ufouser$ cat /proc/asound/card0/codec#* | grep
Codec
> Codec: Realtek ALC892

For motherboard with 3 audio jacks at rear panel and 10 channels HDA codec

you need to retask headphone at front panel as side line out

the easy way is to use hdajackretask (advanced override) or early patching
to retask

if green line out at rear panel has sequence 1 in pin default.

1) blue line jack as Line Out with sequence 2
2) pink mic jack as Line Out with sequence 3
3) front panel headphone to Line out with sequence 4

the three retasked line out should have same default association as the
green line out

in theory, it is possible to add the retask of headphone to line out into
the existing channel mode (8ch) when the codec has extra DAC and volume
control using multi_Ios pin butt need to hack the jack detection control,
disable auto mute and independent headphone when the headphone is retasked
