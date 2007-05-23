From: "Chris Pemberton" <cjpembo@gmail.com>
Subject: bios update alters hda-intel and alsamixer
Date: Tue, 22 May 2007 23:55:55 -0500
Message-ID: <ccc103cf0705222155q70db032ckdedfbbde4ccda832@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by alsa0.perex.cz (Postfix) with ESMTP id 3252E245B3
	for <alsa-devel@alsa-project.org>;
	Wed, 23 May 2007 06:55:56 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so13719ana
	for <alsa-devel@alsa-project.org>; Tue, 22 May 2007 21:55:55 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

After updating the bios on a Lenovo notebook, my hda-intel sound "changed"

Before the bios update I used kernel 2.6.20.3, external
alsa-driver-1.0.14rc3 and the attached patch_realtek.c (in-kernel alsa
wouldn't work)

After the bios update I use just the alsa contained in kernel 2.6.20.3.

Before bios update, my mixer contained many items:  including master,
front, mic, pcm, etc.

Now it only contains master and pcm.

So, I have a few questions:

How can I determine what items are "supposed" to show up in alsamixer?

Where can I submit my laptop soundcard information to help finalize
support of this model/card?

Thank you
