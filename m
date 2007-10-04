From: "kyle cronan" <kyle@pbx.org>
Subject: Why was the built-in software volume control removed?
Date: Thu, 4 Oct 2007 12:22:15 -0700
Message-ID: <f045cde30710041222v64c6f6a6vb68134fd9cd15c01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 495BF2462D
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Oct 2007 21:22:17 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so348628wag
	for <alsa-devel@alsa-project.org>; Thu, 04 Oct 2007 12:22:16 -0700 (PDT)
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

I think I may have posted this to the wrong list.  There wasn't any
response yet on alsa-user, so I'm reposting here.

Summary: I'm seeing a lot of glitches ever since the built-in software
volume was removed.  What was the reason for this change?  Softvol
doesn't work nearly as well for me.
________________

Hi everyone,

I recently updated my media center which is running Fedora devel.  It
pulled down a new kernel with updated ALSA drivers for my HDA audio
chip (Intel 82801H + ALC883).

I use IEC958 output to a pair of studio monitors (good sound with
minimal fuss).  The first thing I noticed about the update was that my
software volume control was no longer saving state.  It was resetting
to something around 80% every time an app opened the audio device, a
level which, in my setup, is quite loud!  Then I saw that in alsamixer
I had no master volume control, not even a PCM control!

So I started experimented with my settings, and I found that after I
selected "PCM" under "Default Mixer Tracks" in gnome-sound-properties
I had a PCM volume control again (still no master), and apps using
alsa output would once again remember the system volume.  Don't know
what that gnome setting actually did, but I've not been able to get it
back to the original state, even when I ctrl-click to deselect "PCM"
in the list.

However, apps that use legacy OSS output still blast me with nearly
full volume every time.  I've also noticed another glitch: using the
volume control applet to adjust my PCM volume, the audio sometimes
skips.  If I quickly drag the slider back and forth, it always does.
I'm pretty sure I would have noticed this if it occurred with my
previous kernel (haven't had a chance to test that yet).

Anyway, looking into this problem, I found the following note in the
changes document at
http://www.alsa-project.org/main/index.php/Changes_v1.0.15rc2_v1.0.15rc3

Sound Core
  ...
  - Remove the built-in software volume control in favour of softvol.

So, my (main) question is: is there a good reason that the built-in
software volume was removed?  I didn't find anything about it in the
archives for this list or -devel.  I'm really not in favor of this
change, because It used to work flawlessly for me, whereas now I'm
running into all these strange problems with my IEC958 output.

Thanks,
Kyle Cronan
<kyle@pbx.org>
