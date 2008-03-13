From: ki.ber.kom.uni.st <ki.ber@kom.uni.st>
Subject: Re: problems howto send simple 'noteon' event with
	pyalsa...
Date: Fri, 14 Mar 2008 00:24:36 +0100
Message-ID: <95e4e4ce0803131624u811b22cs6f957919d3ade26@mail.gmail.com>
References: <95e4e4ce0803130458g7339fd65g7342f8a934db4a52@mail.gmail.com>
	<Pine.LNX.4.61.0803131333560.7942@tm8103.perex-int.cz>
	<17eedd8a0803131107n5721d467r3a73e0d3d688e0c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by alsa0.perex.cz (Postfix) with ESMTP id E56EA2452F
	for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2008 00:24:40 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id c36so1121739ana.80
	for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2008 16:24:37 -0700 (PDT)
In-Reply-To: <17eedd8a0803131107n5721d467r3a73e0d3d688e0c8@mail.gmail.com>
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

i'm happy that gnu world exists ;) aldrin thanx to remind me on that
once again...

On 3/13/08, Aldrin Martoq <amartoq@dcc.uchile.cl> wrote:
> You can send NOTEON events without a queue, but you cannot send NOTE
>  events without a queue. (subtle difference: note_ON_)

clear enough...

>  The following code will work;

worked as charm... many thanx...

> AFAIK, You don't need a port if you are sending events directly.

you are right.. i can send events directly... in my particular case i
like to have ports so i can connect them with other midi ports through
qjackctl or some other graphical app...

>  Now, if you subscribe and connect ports, you don't need to assign them
>  into the event, because a new event is created with
>  snd_seq_ev_set_subs called..

i don't get this one.. what i tried till know is to create in/out
ports (it works...) and then connect them with some existing ones
using seq.connect_ports.. then if i use seq.output_event(event)
drain_output() works fine... i don't get what 'ports assigning into
the event' would be?

>  You can check this and other stuff with the following code:

once more many thanx.. this was very helpful for me.. i'll keep using
pyalsa and i start to call myself happy user of pyalsa from now on ;)

>  I'm planning to move event.set_data() to attributes, like
>  event.note_note, event.note_velocity ... Tell me what you think!

that seems to me more clear and more consistent with event.dest and
probably some other stuff... also it looks more pythonic i would
say... even set_data() is easy to use too..

i use a lot ipython interactive shell so attributes are shown as
result of auto completion + if you would put """documentation
strings""" it will also come out with basic documentation of what is
it for and how to use it...

> Well, that's what asoundlib says... weird, don't you think?

i was pissed but as usually being the lamest in programming i had no
one but myself to blame ;)

> Remember: python is far away of real-time so if you get weirds timings
>  you may reconsider using a queue anyway!

my pyalsa piece of code is part of handling gamepad events in pyqt4
loop so i thought to send events as soon as i get them from
/dev/input/js0 should be handled without any queue and trying to send
them directly.. am i right in this particular set up?

i'll try to get into queues in the later phase of my development...
