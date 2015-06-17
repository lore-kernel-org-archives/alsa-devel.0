From: Jo <contact@samplerbox.org>
Subject: Default volume for all soundcards (-20dB by default?)
Date: Wed, 17 Jun 2015 14:53:03 +0200
Message-ID: <CA+BV=GU0V2_amovM43r5LUhycs67eYSKVAzbu=HQDJ23qDzmvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 23DDF265D21
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 14:53:28 +0200 (CEST)
Received: from mail-lb0-f175.google.com ([209.85.217.175]) by
 mrelayeu.kundenserver.de (mreue102) with ESMTPSA (Nemesis) id
 0MC1MO-1ZDyHl3Dvs-008rPi for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015
 14:53:25 +0200
Received: by lbbwc1 with SMTP id wc1so31055229lbb.2
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 05:53:24 -0700 (PDT)
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

It seems that the default volume for any new soundcard is set by
default to -20dB.
Do you know where is it hardcoded ? In which source file (I used
package "alsa-utils" in Debian)  or which configuration file?

Thanks,
Jo

PS: here's the context :

I woud like to set up the default sound volume once for all, for all
ALSA devices that will be connected ever.
Of course, I could do "amixer ..." or even "alsamixer" to modify the
volume of _currently available_ soundcards.
But I really want to modify the default volume even for future
soundcards that will be added later.
I've seen /var/lib/alsa/asound.state but the content is specific to
_currently connected_ soundcards. What I want is a solution that will
apply to any soundcard that will be connected in the future.

Why do I want this? I'm providing a ready-to-use Debian image for my
project http://www.samplerbox.org.
User #1 might use the computer's built-in-soundcard, User #2 might
have a USB DAC, User #3 might have another soundcard...
I would like to provide a default -3dB volume that will work for any
ALSA soundcard people could have...
