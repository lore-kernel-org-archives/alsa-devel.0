From: Azizul Hakim <azizulfahim2002@gmail.com>
Subject: Can't Unload ALSA Driver Without Disconnecting the
	Device
Date: Fri, 12 Jun 2015 02:28:16 -0400
Message-ID: <CA+k7WwZ+vosLDQ8jz_3E+CtAokjerp_vUtK7bbBCRrD4ZxinOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f182.google.com (mail-ob0-f182.google.com
 [209.85.214.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 51D422666A5
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 08:28:17 +0200 (CEST)
Received: by obcej4 with SMTP id ej4so17459107obc.0
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 23:28:16 -0700 (PDT)
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

Hi,

I've been developing a sound card driver for a USB device using ALSA. My
driver is almost working but I've got one small issue. If I try to unload
the driver module using "rmmod" command  when the device is still connected
to the USB port, it says "Module is in use" even though I'm not playing any
sound files or anything.


If I try to execute the "lsmod" command I see that it is saying the usage
count of my driver to be 1, but it doesn't say anything about who is using
it. Once I disconnect the device from the USB port, I can easily unload the
module.


So it seems to me it won't be possible to unload a sound card driver if the
card is attached in the computer. Is my assumption correct? If not, what
might be some key points to solve the issue?

Thanks for any suggestion

Regards
Azizul Hakim
