From: Stefan Krastanov <krastanov.stefan@gmail.com>
Subject: alc889
Date: Sat, 20 Jun 2009 14:59:32 +0200
Message-ID: <cb66509f0906200559o764a06e8i714cfd08ee908575@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 699C82414A
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Jun 2009 14:59:33 +0200 (CEST)
Received: by bwz11 with SMTP id 11so2330307bwz.32
	for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2009 05:59:32 -0700 (PDT)
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

Hi

I would like to help (or at least help myself) with the creation of a model
config for alc889. I'm not a sound developer.

I'm using a laptop with alc889 based sound card. The reported pins are
really messed up (it's hard not to use more profane expression). My laptop
is Fujitsu-Siemens Amilo xi but the problems are the same as here:
https://answers.launchpad.net/ubuntu/+source/alsa-driver/+question/71205
or here:
http://mailman.alsa-project.org/pipermail/alsa-devel/2008-October/011295.html
namely:
    1.- no jack sensing (extremely annoying - for two years allready)
    2.- misnamed mixers in volume control for gnome or alsamixer (example:
front instead of headphone)
    3.- the volume-control potentiometer on the side of the laptop is not
working
    4.- I need to mute two different channel at the same time (center and
LFE) to mute one physical output (build-in sub-woofer)
    5.- A great deal of other small annoyances destroying the user
experience

I'm using model 3stack-dig and the optical output is working (at least is
lighted up - I do not have the hardware to check it)

My questions are:
    - What I need to do, to create new model option based on 3stack-dig with
different pin mapping?
    - Is it possible that my present configuration (3stack-dig) is using
pins that should not be used? I'm asking in search of an explanation of
problem 4.
    - What I need to do to rename the controls in alsamixer?
    - What to do to repair jack sensing? - that's the most important of all
    - What to do to repair the potentiometer for volume control?

I have seen that hda-analyser can create diff files, but where should they
be used. (And why is hda-analyser not working - I was forced to use
http://ubuntuforums.org/showpost.php?p=7227626&postcount=33. Is it that much
to expect working tools on the official website. I understand that small bug
will always exist, but that one is there for at least 10 months)

I won't be surprised if many of my questions are answered in the
documentation, but I was unable to find anything useful. It would be enough
to point me a place to start reading.

I know you guys are working hard and you have done great things, but it's
really hard to find something in the documentation(which is occasionally
quite old)

Best regards and thank you for the great work
Stefan Krastanov
