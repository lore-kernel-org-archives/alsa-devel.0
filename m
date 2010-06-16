From: Dennis Borgmann <dennis.borgmann@googlemail.com>
Subject: snd_pcm_wait won't return
Date: Wed, 16 Jun 2010 08:42:31 +0200
Message-ID: <4C187257.6060105@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id E9E6924154
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jun 2010 08:42:34 +0200 (CEST)
Received: by fxm20 with SMTP id 20so585735fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 15 Jun 2010 23:42:34 -0700 (PDT)
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

Dear alsa-devel list!

I already posted this on alsa-users, but this list doesn't seem to be
that crowded so I will give it a try in here...

I am using the alsa-lib in one of my projects and within this project,
there is a call for snd_pcm_wait() on a machine, that plays sound. The
call itself looks like this:

snd_pcm_wait( pcm_handle, 1000 );

A few steps before, I had the timeout set to unlimited (-1), which
sometimes did not return at all. Now, it sometimes returns after the
timeout, but in result I cannot write anything to the soundcard anymore.
This error is reproducable if there are many underruns in a row. Since
this program runs in a network environment and receives its data from a
datastream, I sometimes cannot avoid those underruns.

So, what could be the error, that leads to alsa not responding anymore?
I can only revitalize the system after such an error by rebooting the
whole system (well, at least I did not find another solution like
snd_pcm_prepare or snd_pcm_recover).

Which additional informations do you need? What is there, that I can
provide in addition? Could this be an alsa-bug?

Kind regards,
Dennis
