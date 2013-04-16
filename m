From: =?ISO-8859-1?Q?Daniel_Sch=FCrmann?= <daschuer@mixxx.org>
Subject: Re: Solved Hercules RMX2
Date: Tue, 16 Apr 2013 17:12:08 +0200
Message-ID: <CABVYHNis8cn5Y_BeTMQv0hn_AaJDsOw+=GaX7pFy9JjDvP5+Tw@mail.gmail.com>
References: <CABVYHNhLjkAknhypk3howphQk8KWV6OqJ415x1A-YAGVC-0J3w@mail.gmail.com>
 <516D5BC0.9020204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f170.google.com (mail-ie0-f170.google.com
 [209.85.223.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 091572610A7
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 17:12:09 +0200 (CEST)
Received: by mail-ie0-f170.google.com with SMTP id c11so638491ieb.29
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 08:12:08 -0700 (PDT)
In-Reply-To: <516D5BC0.9020204@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Gabriel,

Thank you for your quick response.
The patch against the alsa-kernel is also attached at
https://bugs.launchpad.net/mixxx/+bug/1096687 and here:

diff --git a/sound/usb/helper.c b/sound/usb/helper.c
index c1db28f..e044804 100644
--- a/sound/usb/helper.c
+++ b/sound/usb/helper.c
@@ -23,6 +23,9 @@
 #include "helper.h"
 #include "quirks.h"

+/* Hercules RMX2 needs 1240 ms for setting the sample rate the first time =
*/
+#define USB_MSG_TIMEOUT 1500
+
 /*
  * combine bytes and get an integer value
  */
@@ -93,7 +96,7 @@ int snd_usb_ctl_msg(struct usb_device *dev, unsigned
int pipe, __u8 request,
 			return -ENOMEM;
 	}
 	err =3D usb_control_msg(dev, pipe, request, requesttype,
-			      value, index, buf, size, 1000);
+			      value, index, buf, size, USB_MSG_TIMEOUT);
 	if (size > 0) {
 		memcpy(data, buf, size);
 		kfree(buf);



Kind regards,

Daniel





2013/4/16 Gabriel M. Beddingfield <gabrbedd@gmail.com>

>
> Hi Daniel,
>
>
> On 04/15/2013 03:04 PM, Daniel Sch=FCrmann wrote:
>
>> Hallo Alsa Developers,
>>
>> I have fixed Support for Hercules RMX2.
>>
>> You can find the Bug and the patch here:
>> https://bugs.launchpad.net/**mixxx/+bug/1096687<https://bugs.launchpad.n=
et/mixxx/+bug/1096687>
>>
> [snip]
>
>  Is it possible to include the fix in trunk?
>>
>
> Since the RMX2's /driver/ isn't in the Linux kernel -- the answer is
> probably no.  Notice that the DEB package has "DKMS" in the name --
> indicating that this is an out-of-tree driver.
>
> So, you would need to start by submitting a patch to add the RMX driver to
> the kernel.
>
> -gabriel
>
>
>
