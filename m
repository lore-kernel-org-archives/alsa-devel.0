From: Aleksey Midenkov <midenok@gmail.com>
Subject: Realtime controlling of ALSA parameters from UI
Date: Fri, 17 Feb 2012 14:18:02 +0400
Message-ID: <CAF8BazCiswNQbrUk9CPkz2bFq80qK2qXMJ2trjCBMwwv8FaX3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3958C103FD0
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 11:18:03 +0100 (CET)
Received: by iabz21 with SMTP id z21so4522616iab.38
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 02:18:02 -0800 (PST)
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

Hello guys!

I want to suggest you an idea of what I am thinking for a long time.
And want to know of what you are thinking on it from perspective of
how hard it would be to implement. I'm pretty sure the feature will be
well popular because for me as an ordinary user it would be great
stuff!

So to the point. What I am saying about is the ability to control
parameters from asound.conf at user level. This would give us such
great things like switching sound output realtime or control each
channel volume level in mixer GUI.

If you will suggest userpace daemons like Pulse or Jack. There are
some situations (like playing piano f.ex.) where realtime really
matters, where such daemons put unacceptable latency. Another point is
that they are not such feature rich. They cannot downmix f.ex. with
controlling of each channel volume level (please tell me if I am wrong
here).

Every opinion is appreciated!
