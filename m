From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: SPDIF output finally working properly with CS4630
Date: Fri, 26 Jul 2002 08:40:51 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D40EEF3.3050502@cucumelo.org>
References: <3D3DBDA2.10602@cucumelo.org> <20020724013400.GA5214@porky> <3D3E2D08.3070800@cucumelo.org> <20020724181919.GC1681@porky> <3D3EF4CA.1090504@cucumelo.org> <20020724201201.GI1681@porky> <3D3F0710.1060307@cucumelo.org> <20020724212315.GK1681@porky> <3D3F21CD.9090600@cucumelo.org> <20020725222328.GA2919@porky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Peter Heatwole <peter599@gotnet.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>    I can watch what you're saying as I mute and unmute "IEC 958" in
> alsamixer. Muted, the 9th dword is 00a0, unmuted it's 00e0. Side 
> question:
> you referenced AsynchFGTxSCB. What's the FGT acronym stand for?) 


I believe it stands for "Asynchronous Foreground transfer", it's the task
in DSP that's responsible to tranfer samples from Foreground to
Hyperforeground.

>
>    Here's a strange one. With "IEC 958" muted, I view dsp_scb, and the
> first dword of SPDIFOSCB is 00000000. I unmute "IEC 958", and I can watch
> the first dword of SPDIFOSCB change each time I view dsp_scb. Here's a 
> list
> of each individual number I get (duplicates have been removed):

The SPDIFOSCB task runs in Hyperforeground on DSP, it's responsible
to transfer samples to the HW FIFO.

>
> 80005001
> 80001001
> 80000001
> 80002001
> 00001001
> 80003001
> 80006001
> 00006001
> 00003001
> 00004001
> 80003001
> 80004001
> 00000001
> 00007001
> 80005001
> 00005001
> 80007001
> 00002001
> 00005001

If you want to find out more details about this, the CS4630 design spec.
Page 228. the SPDOUT_STATUS register.

>
>    I tried this with and without sounds playing (though I still can't 
> hear
> them). Do you have any information regarding what each bit stands for in
> the first dword of SPDIFOSCB? (if you do, could you point me to where you
> obtained this information so I can try to educate myself?)  I'm writing
> this because it seems strange; I don't understand why the status bits 
> would
> keep changing for no (apparent) reason.

We dont have any documentaion about the SCB's. The references I got are 
DSP assembler
sources of some tasks some examples about how to setup the SCB's.
Some hints from Cirrus, and analyzing the assembler sources (and 
binaries) is where i've been
token this conlusions, what probes that i'm right is that it seems to 
work, but I can be wrong in
some points.

Hopefully the code I wrote helps uncovers some internals of the DSP, 
before you
start reading the assembler sources by "the hard way" take a look at 
alsa-kernel/include/cs46xx_dsp_scb_types.h
and alsa-kernel/include/cs46xx_dsp_task_types.h first.

/Benny




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
