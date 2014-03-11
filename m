From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HDA jack retask for Debian 7.4 NOT working
Date: Tue, 11 Mar 2014 19:25:36 +0800
Message-ID: <CAN8cciYkcwtOv17kFxNsPXXoye=P3yk4d5YbCoSbQYk_6+R0ng@mail.gmail.com>
References: <CAAh=20RH3jg+W0PQOnu2NU+HPVpp9GT=ZOnd46PZr4mgweGJJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f47.google.com (mail-qg0-f47.google.com
 [209.85.192.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CEA4261696
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 12:25:37 +0100 (CET)
Received: by mail-qg0-f47.google.com with SMTP id 63so5917284qgz.6
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 04:25:36 -0700 (PDT)
In-Reply-To: <CAAh=20RH3jg+W0PQOnu2NU+HPVpp9GT=ZOnd46PZr4mgweGJJg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Subodh Chiwate <subodh.austin@gmail.com>
Cc: alsa-user@lists.sourceforge.net, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> Hi,
> I am trying to get surround 7.1 on debian 7.4 Wheezy.
> As guided by hda-jack-retask readme I built it from source on my system.
> But the changes are not reflecting and no errors by utility as well.
>
> I am getting Alsa 1.0.25 from the repository.

You need alsa driver 1.0.27 or later which hda driver use auto generic
parser instead of using static quirk if you need retasking headphone to
side line out

> Do I need to build the latest version from source to get hdajackretask as
part of alsa-tools ?
> Any other suggestions to get the 7.1 working are welcome.

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/Documentation/sound/alsa/HD-Audio.txt

hdajackretask just a GUI program to create a firmware file for fixup pincfg
by early patching
