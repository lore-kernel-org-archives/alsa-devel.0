From: "Ignacy Kasperowicz" <fikufik@gmail.com>
Subject: Re: Problem with setting period time and buffer time.
Date: Tue, 19 Feb 2008 13:41:15 +0100
Message-ID: <9673d3ac0802190441h40baa705oabf73b57d32314fe@mail.gmail.com>
References: <9673d3ac0802181557m6bd35f28w7680c9a9a979ab67@mail.gmail.com>
	<47BA908B.7040700@ladisch.de>
	<9673d3ac0802190320gab8bb7ara92a27b7f602d28b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A2C2103918
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 13:41:18 +0100 (CET)
Received: by el-out-1112.google.com with SMTP id z25so1022659ele.8
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 04:41:17 -0800 (PST)
In-Reply-To: <9673d3ac0802190320gab8bb7ara92a27b7f602d28b@mail.gmail.com>
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

Ok, so I misunderstood the idea of a period variable, many thanks for
explanation Clemens.

I've just read that buffer_time also isn't what I think it was ;) It's
a size of the ring buffer of sound card and it's length depends on
hardware, am I right?
So the best way is to depend on default values of hardware?

Anyway is there a method to play my wave for a specified short time?
As I can see using timer interface is the only solution but still
can't google anything useful :( Small example how to apply
timers will be appreciated (I saw example timer.c from alsa-lib, but
I'd prefer to read some explanation how the code works).

Thanks from advance for any replays.

-- =

################################################
gry =B6wietlicowe drog=B1 do wy=BFszej fazy przemian.
gg:681548 jid: fik@jabbim.pl usecide.net
################################################
