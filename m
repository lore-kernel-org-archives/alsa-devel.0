From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: Solved Hercules RMX2
Date: Tue, 16 Apr 2013 07:10:08 -0700
Message-ID: <516D5BC0.9020204@gmail.com>
References: <CABVYHNhLjkAknhypk3howphQk8KWV6OqJ415x1A-YAGVC-0J3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
 [209.85.192.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C6E62625EC
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 16:10:22 +0200 (CEST)
Received: by mail-pd0-f174.google.com with SMTP id p12so314587pdj.19
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 07:10:20 -0700 (PDT)
In-Reply-To: <CABVYHNhLjkAknhypk3howphQk8KWV6OqJ415x1A-YAGVC-0J3w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Daniel_Sch=FCrmann?= <daschuer@mixxx.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi Daniel,

On 04/15/2013 03:04 PM, Daniel Sch=FCrmann wrote:
> Hallo Alsa Developers,
>
> I have fixed Support for Hercules RMX2.
>
> You can find the Bug and the patch here:
> https://bugs.launchpad.net/mixxx/+bug/1096687
[snip]
> Is it possible to include the fix in trunk?

Since the RMX2's /driver/ isn't in the Linux kernel -- the answer is =

probably no.  Notice that the DEB package has "DKMS" in the name -- =

indicating that this is an out-of-tree driver.

So, you would need to start by submitting a patch to add the RMX driver =

to the kernel.

-gabriel
