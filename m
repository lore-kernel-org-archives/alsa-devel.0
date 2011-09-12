From: Raymond Toy <rtoy@google.com>
Subject: Determining the plugins being used?
Date: Mon, 12 Sep 2011 12:16:36 -0700
Message-ID: <CAE3TgXGk9uaK0ESwUj2OGXKjBhRpi8tUgQXRT8GOMHLhX8ELGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 621CE2433C
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 21:16:45 +0200 (CEST)
Received: from hpaq12.eem.corp.google.com (hpaq12.eem.corp.google.com
	[172.25.149.12]) by smtp-out.google.com with ESMTP id p8CJGcos018153
	for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2011 12:16:38 -0700
Received: from gwj18 (gwj18.prod.google.com [10.200.10.18])
	by hpaq12.eem.corp.google.com with ESMTP id p8CJGFV1025186
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2011 12:16:37 -0700
Received: by gwj18 with SMTP id 18so439471gwj.27
	for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2011 12:16:36 -0700 (PDT)
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

Is there a way to determine the plugins being used?  I notice that
snd_pcm_dump produces information about the various plugins that are being
used.  In one of test case, aplay -v shows that it's using  a rate
conversion plugin, a slave for Direct Stream Mixing PCM, and finally, the
actual hardware PCM card.

For my application, it would be nice to know if we're using the pulse audio
plugin so that I can setup our code appropriately.  (The period interrupts
are not what we were expecting, so we need to use a different code path.)
 If we're using the dmix plugin, the period interrupts can match our
expectations, so we want to use a low-latency path.

What is the appropriate way to determine the plugins used?

Ray
