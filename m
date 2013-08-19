From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: [PING!] Re: HDMI audio is not working on my new desktop
Date: Mon, 19 Aug 2013 21:22:22 +0600
Message-ID: <CAN_LGv1eGP=Krg_zRXhLhLVPv12dpybKj_fy+r=oS4nSnXRGCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f46.google.com (mail-qe0-f46.google.com
 [209.85.128.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 836F02650F5
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2013 17:22:23 +0200 (CEST)
Received: by mail-qe0-f46.google.com with SMTP id f6so2689019qej.5
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2013 08:22:22 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2013/8/14 Alexander E. Patrakov <patrakov@gmail.com>:
> Hello.
>
> I built a new desktop PC based on the Gigabyte H87N-WIFI motherboard.
> It has one DVI and two HDMI outputs. However, I cannot get any sound
> over HDMI. The same OS image works perfectly on my laptop that also
> has an HDMI output.
>
> This is not a pulseaudio problem, as I don't get any sound even if I
> test with this command:
>
> pasuspender -- speaker-test -c2 -D hdmi:0,2  # or, for that matter, 0,0 or 0,1
>
> Alsa-info.sh has uploaded its output to
> http://www.alsa-project.org/db/?f=1ad7192a15ff4a70b5ddb2579476dbb98adbd929
>
> Please note this error in dmesg, it may be relevant:
>
> [    1.803595] hda_codec: invalid CONNECT_LIST verb 5[1]:0
> [    1.803719] hda_codec: invalid CONNECT_LIST verb 7[1]:0

As nobody replied, I have converted this into a formal bug report:
https://bugzilla.kernel.org/show_bug.cgi?id=60769

Haswell people, _please_ comment on the bug.

-- 
Alexander E. Patrakov
