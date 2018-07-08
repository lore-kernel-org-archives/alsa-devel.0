From: =?UTF-8?Q?Giedrius_Trainavi=C4=8Dius?= <giedrius.trainavicius@gmail.com>
Subject: Hiding some of the controls defined in codec driver
 from machine driver context
Date: Sun, 8 Jul 2018 11:13:55 +0300
Message-ID: <CABpuRUNd3gwSAcd-unmRy+tOxfmqK1uUSdWURXRYCqcp1tf+kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f65.google.com (mail-vk0-f65.google.com
 [209.85.213.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D796626739D
 for <alsa-devel@alsa-project.org>; Sun,  8 Jul 2018 10:13:57 +0200 (CEST)
Received: by mail-vk0-f65.google.com with SMTP id 125-v6so8926303vke.11
 for <alsa-devel@alsa-project.org>; Sun, 08 Jul 2018 01:13:57 -0700 (PDT)
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

Hello,

Is it possible to 'hide' some of the controls of the codec in the machine
driver? The codec I'm using exposes many advanced controls which are useful
for board developers, but not for the end user, so I'd like to define my
own 'simplified' controls, and take care of board specific logic internally
in the machine driver.

I found this old discussion on the topic:
https://www.spinics.net/lists/alsa-devel/msg36386.html - I'm targeting
kernel 4.14, maybe there's already some means to achieve this?

Thank you!
Giedrius.
