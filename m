From: "amidi@LEFerguson.com" <amidi@LEFerguson.com>
Subject: Help with midi player application
Date: Fri, 17 Feb 2017 14:09:45 +0000
Message-ID: <BN6PR05MB3009207D0FB9108B1C1B052BD55D0@BN6PR05MB3009.namprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03on0137.outbound.protection.outlook.com [104.47.40.137])
 by alsa0.perex.cz (Postfix) with ESMTP id 95CD42671B9
 for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2017 15:09:48 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I am hoping someone has a bit of patience to help.  I apologize in advance if this is not appropriate use of this mailing list.

I am trying to incorporate ALSA's sequencer within an application I am writing to play MIDI pieces, and provide controls (start at measure, tempo changes, etc), while output is sent to a piano player system with midi i/o (specifically it's a Pianodisc system). The result (if it ever works) will be open source.

The good news is I can get it to work. The bad news is I am having some kind of timing or buffering issue, and am at a bit of a loss where to look.

I am convinced the problem is in my code, or environment, as I can get pmidi (1.7.1) to work (including build it from source, so same compile environment).

The actual application is in a QT5.8 application, so it is conceivable that some aspect of QT's environment is at issue.  I have embedded the calls to the ALSA sequencer inside of a separate QThread so as to isolate it from QT's event loop.  Since the code fails only in context, it is not practical to post the whole code.  And yes I'm sure it is related to my code, I get that, am hoping for some trouble shooting ideas, or pointers to tools.

The symptoms are on a fast, long piece play hangs for a long period of time (many seconds).  I put into the loop queries as to queue info/state/etc, and what I see is the queue tick advancing correctly during this pause, but the events in the queue are steady at about 80%full and not emptying.  I have set this up to run through qmidinet which outputs each notes as ALSA hands it off, and that pauses also (qmidinet is not the cause; writing direct to the midi port also pauses).

My hope with this email is to get some suggestions how to find out what is happening when it pauses inappropriately. "It" here is whatever processes are draining the queue; the thread making the snd_seq calls continues to run, I can query the queue and see its status, etc.

I have tried this with no self-written buffer management, just letting ALSA pause the thread; I also have it running managing the queue myself looking for it getting near full and waiting until it gets more empty (staying above the "room" size).  Neither work, both do approximately the same, though trying to manage the buffer seems to work better and gives me event-count visibility in the queue.

Allocating a much larger queue buffer (snd_seq_set_client_pool_output) delays the pause significantly but does not solve the problem.  The queue is not full (but also is not empty) when the pauses occur.  My initial thoughts were the tick in the events was incorrect and so waiting, but that is not the case as best I can tell (also, that would not cause a larger buffer to pause less often).  Something is stopping the queue from processing outbound for longish periods.

Essentially what I do is:

snd_seq_open to get the handle
send_seq_alloc_queue
snd_seq_client and snd_seq_create_simple_port  to  get the client port
snd_seq_connect_to to connect
snd_seq_set_queue_tempo (initially with default
snd_deq_start_queue
snd_seq_drain_output (until ret = 0)

Then I loop through all the midi events. Each event has:

snd_seq_ev_schedule_tick called with parameter 2 = 1 for relative ticks.
snd_seq_event_output
snd_seq_drain_output (until ret = 0)
(every 10 events) check queue events and if getting full pause for 10ms

I have tried it with and without the drain after each send, neither one works, with the drain seems to work a bit better (and with the drain I can call the queue status and get more info).

The environment is a HyperV x64 Ubuntu 16.04.01 install with QT5.8 built from source, and ALSA from the distro version (not built from source).   The same thing occurs on a Raspberry Pi 3B (which is my eventual target) running Ubuntu 16.04 Mate.

Both environments will run pmidi with the same song correctly.  Yes, I know it's my code, not an ALSA bug.

What I'm hoping is some suggestion as to how to get more visibility as to what is happening when it pauses.  Some kind of trace or debug mode, hopefully without trying to build and manually instrument ALSA.

Conversely.... maybe I am using ALSA inappropriate to send just to the sequencer and on to a midi device?   I just wanted its scheduler to deal with timing, there is no near term plan to use a synthesizer or other connection instead.

Any suggestions or insights appreciated.  I started with too little hair, and fear even more has been pulled out now.

Linwood Ferguson
