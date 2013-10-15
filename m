From: =?ISO-8859-1?Q?st=E9phane_cerveau?= <scerveau@gmail.com>
Subject: mxc-spdif delay: miss 1-2s at the beginning of the song
Date: Tue, 15 Oct 2013 16:21:15 +0200
Message-ID: <525D4F5B.6050105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 043682610A0
 for <alsa-devel@alsa-project.org>; Tue, 15 Oct 2013 16:21:17 +0200 (CEST)
Received: by mail-wi0-f173.google.com with SMTP id i19so1110297wiw.12
 for <alsa-devel@alsa-project.org>; Tue, 15 Oct 2013 07:21:17 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dear all,

I'm facing a delay during startup missing 1-2s of the song when i'm =

using mxc spdif with aplay.
I guess its a problem with spdif synchronization. If i put a =

msleep(1000) at the end of the function =

mxc-spdif.c:mxc_spdif_playback_start, the playback is ok.

Is there anyone who already faced this issue?
BR.

St=E9phane
