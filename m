From: ki.ber.kom.uni.st <ki.ber@kom.uni.st>
Subject: pyalsa with threads allowed for python
	(Py_BEGIN_ALLOW_THREADS & Py_END_ALLOW_THREADS)
Date: Sat, 17 May 2008 18:40:04 +0200
Message-ID: <95e4e4ce0805170940wb1aa76et3003ab926bfe03eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by alsa0.perex.cz (Postfix) with ESMTP id 8537C103800
	for <alsa-devel@alsa-project.org>;
	Sat, 17 May 2008 18:40:06 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so305545and.80
	for <alsa-devel@alsa-project.org>; Sat, 17 May 2008 09:40:05 -0700 (PDT)
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
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

i develop my app iterating ipython interactive sessions with pasting
the good code into files (which eventually being loaded back to
ipython sessions)...

for that kind of development i need pyalsa to run in python threads...
when i did (as it is now) alsaseq.Sequencer.receive_events(100) in
infinite loop of pyqt4 thread it always steal interaction from ipython
and it makes interaction unusable... it gets back every now and then
almost randomly and definitively not frequent enough to be usable..
hope this description explained enough of what's happening...

the solution was to make time.sleep(.001) at the end of while True:
loop... it took me several hours to find out the solution... i was
quite happy with the solution but my guru friends told me that's dirty
and i'm lame...

the other solution is in particular case of receive_events to put
Py_*_ALLOW_THREADS

    Py_BEGIN_ALLOW_THREADS;
    ret = poll(self->receive_fds, self->receive_max, timeout);
    Py_END_ALLOW_THREADS;

around poll...

this url should explain this strange phenomena (to me) to the real
programmers: http://www.python.org/doc/1.5.2/api/threads.html

in my case my programming guru akapav sort it out after couple of
minuts checking the code...

hope this is of some interest to pyalsa devs... i definitively would
need most of the functions being ready to run in threads....

thanx.. keep up the good work...
