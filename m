From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA seq Segfault on snd_seq_event_output_direct
 in 64bit
Date: Mon, 06 Sep 2010 18:43:09 +0200
Message-ID: <4C851A1D.1090200@ladisch.de>
References: <20100905011718.813dd7dd.holborn@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 397452460B
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Sep 2010 18:43:01 +0200 (CEST)
In-Reply-To: <20100905011718.813dd7dd.holborn@telefonica.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Josep Andreu <holborn@telefonica.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Josep Andreu wrote:
> I run this programs in a lot of 32 bit computers without problems but
> I received various emails form ppl that has 64bit and the program
> segfault in:
> 
> #0  0x00007f5e6c1cb9a6 in snd_seq_event_output_direct () from /usr/lib/libasound.so.2
> 
> Unfortunately I dont have any 64 bit computer to check but I made some
> checks with some users and the  incredible thing is the segfault is
> produced after the function is called 90 times ...  at the 91 segfault.
> And is not related to the midi event data because previously I send the
> same data.
>  
> This is the function:
> 
> void
> RMGMO::enviocontrol(int canal,int control, int value)
> {
> 
> snd_seq_event_t midievent;               
> snd_seq_ev_clear (&midievent);
> 
> snd_seq_ev_set_controller (&midievent, canal, control, value);
> snd_seq_ev_set_subs (&midievent);
> snd_seq_ev_set_direct (&midievent);
> snd_seq_event_output_direct (midi_out, &midievent);
> 
> }

This function looks correct.

It's possible that the memory in midi_out got corrupted.
Try running stygmorgan with Valgrind.


Regards,
Clemens
