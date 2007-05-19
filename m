From: Jasiu <kiputnik@gmail.com>
Subject: Broken JACK plugin in alsa-plugins and a way to fix it.
Date: Sat, 19 May 2007 15:44:45 +0200
Message-ID: <f13492b00705190644s51a0cc99g95e676257a4e9044@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by alsa0.perex.cz (Postfix) with ESMTP id 14769244E6
	for <alsa-devel@alsa-project.org>;
	Sat, 19 May 2007 15:44:46 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c18so310724anc
	for <alsa-devel@alsa-project.org>; Sat, 19 May 2007 06:44:46 -0700 (PDT)
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

Hi.

I want to note that JACK plugin in alsa-plugins in broken. (At least
on my two systems.) It just plays for a few seconds and then stops
hanging the application that was sending data to it. When it hangs
jackd spits out this:

subgraph starting at alsa-jack.jackP.3635.0 timed out
(subgraph_wait_fd=7, status = 0, state = Running)

What I want to note is that there is a fix to that and I would like it
to be included in the tree. I'm not sure if it doesn't break anything
else, but it works for me ok.

Open pcm_jack.c and on the line 146 you'll find:

write(jack->fd, buf, 1); /* for polling */

Deleting this seems to get rid of the problem.
So please if you can patch this out. (I didn't make a patch myself
since this is so tiny fix that it isn't really worth.)

Cheers.
