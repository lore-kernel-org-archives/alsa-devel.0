From: Azizul Hakim <azizulfahim2002@gmail.com>
Subject: How to Configure Appropriate runtime->hw in ALSA Driver
Date: Sun, 5 Jul 2015 02:42:24 -0400
Message-ID: <CA+k7WwaxTObWDjn-7SqPkzTNNgf9+ManyT3mk8wDxLZZzn5OYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f178.google.com (mail-ob0-f178.google.com
 [209.85.214.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 0405C260435
 for <alsa-devel@alsa-project.org>; Sun,  5 Jul 2015 08:42:26 +0200 (CEST)
Received: by obdbs4 with SMTP id bs4so89690582obd.3
 for <alsa-devel@alsa-project.org>; Sat, 04 Jul 2015 23:42:25 -0700 (PDT)
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

What is the best way to set the *runtime->hw* parameter in ALSA driver.
>From sample ALSA driver tutorial I understand we have to declare a
*structure snd_pcm_hardware*  where we define all sound parameters
like *STEREO/MONO,
RATES* etc. Now at run time we can play sound files of different
parameters. How ALSA behaves if the audio file parameters doesn't match
with the *structure_snd_pcm_hardware* parameters? So if we set MONO in our
structure, but play a audio file with STEREO data, does ALSA automatically
configure the data according to its structure or we're going to get some
kind of disruption?


If we want our driver to play any sound file, what should be the
appropriate *structure snd_pcm_hardware *parameters?

Thanks
-Azizul Hakim
