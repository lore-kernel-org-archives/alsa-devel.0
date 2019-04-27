From: Mathias Nielsen <lynge@lynges.net>
Subject: Help with cross compilation of alsa-lib.
Date: Sat, 27 Apr 2019 17:29:53 +0200
Message-ID: <CAJjsnGEZ_MeAMtZJqzmgfDmeY+WqzWaz_US31Nhqx7EzU-jpGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it1-x144.google.com (mail-it1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 850D3F80CAB
 for <alsa-devel@alsa-project.org>; Sat, 27 Apr 2019 17:30:05 +0200 (CEST)
Received: by mail-it1-x144.google.com with SMTP id e13so10296830itk.4
 for <alsa-devel@alsa-project.org>; Sat, 27 Apr 2019 08:30:05 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi. I have made a small Go app (https://github.com/Lynges/susimup). It is a
simple music player for the console and one of the libraries I use has alsa
as a dependency on linux. I would really like to have cross compilation
working so that I might provide binaries for the various platforms.

I have tried getting it working using xgo (https://github.com/karalabe/xgo)
and it solves the problem for both windows and macos, but on linux I have
to get alsa-lib injected and compiled.

I have created an SO question with some more details here: (
https://stackoverflow.com/questions/55656194/xgo-cross-compile-not-working-for-alsa-lib
)

I realize that I am asking no small thing unless someone on this list is
very familiar with both xgo and alsa, but I could really use some help
getting this working and I have spent quite a lot of time searching for
other solutions and found nothing so I guess it would be helpful to others
as well as my self.

I do not have a whole lot of experience getting cross compilation for C
working and the fact that the process is somewhat obscured by xgo does not
make it any easier. One thing I have not tried yet is just forking xgo and
using a different version of their docker image that then has the alsa
packages installed with multiarch, but I have no idea how to make that work
or if it even could work.

Any more information I can provide, please dont hold back.

-- 
Best regards

Mathias Nielsen
