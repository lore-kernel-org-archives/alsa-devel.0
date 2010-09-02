From: Camilo Polymeris <cpolymeris@gmail.com>
Subject: HCTL element callback
Date: Thu, 02 Sep 2010 17:48:29 -0400
Message-ID: <1283464109.6921.10.camel@aviva.ttga.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 02131243C0
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Sep 2010 23:48:44 +0200 (CEST)
Received: by yxj4 with SMTP id 4so409495yxj.38
	for <alsa-devel@alsa-project.org>; Thu, 02 Sep 2010 14:48:42 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello.
I am writing this mixer app:
http://emutrix.googlecode.com

I have trouble with callbacks. So far I have implemented callbacks for
the master volume fader and clock rate selection (integer and enum,
resp.)
But "pad" callbacks (boolean) won't work. In fact, I have noticed that
alsamixer 1.0.22 also doesn't react to pad changes from the application.
But the driver reacts to both as expected, so we're dealing with the
same element.

I set callbacks with this:
snd_hctl_elem_set_callback(el, cb);

And periodically poll them with:
    if (snd_hctl_wait(hctl, 10))
        snd_hctl_handle_events(hctl);

As I said, integers and enums I have tried so far, work.

Thanks for any help,
Camilo
