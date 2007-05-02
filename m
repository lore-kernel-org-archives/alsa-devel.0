From: Ciaccia <ciacciax@yahoo.com>
Subject: Re: alsa driver api
Date: Wed, 2 May 2007 10:56:18 -0700 (PDT)
Message-ID: <99356.5221.qm@web31007.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web31007.mail.mud.yahoo.com (web31007.mail.mud.yahoo.com
	[68.142.200.170]) by alsa0.perex.cz (Postfix) with SMTP id 0DFB724467
	for <alsa-devel@alsa-project.org>;
	Wed,  2 May 2007 19:56:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michel Benoit <murpme@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Michel,
Maybe you are referring to my post. I always use alsa-lib to send data to the driver, I think it is the easiest way and preferred way.

Months ago I wanted to do the same (i.e. send data to the alsa-driver without alsa-lib) but then I understood this was not the right way. I'm not saying you cannot or should not try that, but from my experience (I spent a lot of time) it's not going to work.

The problem I had was that my system did not support shared objects, nor -ldl, so I could not user the "standard" alsa-lib (which usually require pthread, dl, an *.so). Then Takashi gave me a patch for that, and now I'm an happy "static" alsa-lib user.

Maybe one of the gurus (Takashi?) will give you some tips, but I think you really need a good reason for that.

Good luck, sorry for not helping you
Andrea

----- Original Message ----
From: Michel Benoit <murpme@gmail.com>
To: ciacciax@yahoo.com; alsa-devel@alsa-project.org
Sent: Wednesday, May 2, 2007 7:40:29 PM
Subject: alsa driver api

Hi

Does anyone have some code examples that show how to send pcm samples
directly to an alsa driver.  I'm (still) having trouble building/using
alsa-lib and I want to make sure that my driver works correctly. If I
understand correctly it is possible to send sound samples using the
alsa driver api only (no alsa-lib).

All I want to do for now is send a fixed sine wave to the driver. I
saw some code snippets that seemed to do just that in a recent email
on this list but it would help a lot if I could have a look at the
complete application.

Thanks,

Michel




__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
