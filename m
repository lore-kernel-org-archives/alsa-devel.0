From: chri <chripell@gmail.com>
Subject: maximum tolerable sampling frequency difference for a
	driver
Date: Tue, 11 Nov 2008 17:17:00 +0100
Message-ID: <cabda6420811110817u42eafc74wfde36de113c98df1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 5ACD9243D8
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 17:17:01 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 21so1124758eyc.56
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 08:17:00 -0800 (PST)
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

Let's say that the driver cannot set the exact sampling frequency
asked via hwparms but something near (because of the granularity of
the result of the clock division). What is the maximum difference that
should be accepted (in Hz or in %)? I guess that there are 2 factors
playing a role:

1) if the frequency is too different then the upper layers report a
undeflow/overflow

2) the sound just doesn't sound good (just a bit too presto or too adagio)

So what difference should be accepted instead of returning -EINVAL?

Thanks,

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
