From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Urgent Help Needed:ALsa Querries
Date: Tue, 23 Dec 2008 22:39:38 +0100
Message-ID: <20081223223938.b040ead2.pochini@shiny.it>
References: <35fa40850812200614q4bafd136xd31397116e1d28a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out25.alice.it (smtp-out25.alice.it [85.33.2.25])
	by alsa0.perex.cz (Postfix) with ESMTP id A43AB1037F4
	for <alsa-devel@alsa-project.org>; Tue, 23 Dec 2008 22:44:01 +0100 (CET)
In-Reply-To: <35fa40850812200614q4bafd136xd31397116e1d28a7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: SUBHRANIL CHOUDHURY <subhra85@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 20 Dec 2008 19:44:33 +0530
"SUBHRANIL CHOUDHURY" <subhra85@gmail.com> wrote:

> I have some doubts on the ALSA programming,
> 1)My ALSA driver supports minimum Period Bytes size as 32 bytes, but when i
> set the period size as 512 bytes it is always setting to 1024 bytes.I am
> using the function "snd_pcm_hw_params_set_period_size_near()" . What might
> be wrong here?Is the function what i am using correct?

pcm.h:int snd_pcm_hw_params_set_period_size_near(snd_pcm_t *pcm, snd_pcm_hw_params_t *params, snd_pcm_uframes_t *val, int *dir);

That function gets the number of *frames*, not bytes. If you are setting up
a pcm device to play a 1 channel, 16 bits sound, then 512 frames are 1024
bytes long. Note that even if the hardware supports a feature, the driver
may not.


> 2)How the Library functions and the Driver functions interact, what is the
> interface between the library functions and driver functions?Is there any
> document which explains this. I got a document which explains how to write
> ALSA driver.But it does not mention the interface with the library.

You shouldn't care on how alsa-lib and alsa-kernel interact, unless you are
writing some low-level stuff. In that case, I guess you have to dig into
the sources :)
If you find good docs on alsa-lib let me know...


> 3)How Can we achive MIC and LINEIN switching using the mixer?What library
> function do i need to use to achive this?

You have to use the control interface. Each card is different, but naming
conventions usually make easy to locate the right switch. For example:

 $ amixer contents
[...]
numid=146,iface=CARD,name='Digital mode Switch'
  ; type=ENUMERATED,access=rw------,values=1,items=3
  ; Item #0 'S/PDIF Coaxial'
  ; Item #1 'S/PDIF Optical'
  ; Item #2 'ADAT Optical'
  : values=0
numid=149,iface=CARD,name='Phantom power Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
[...]


> 4)If i want to get the Timestamp for each buffer captured, what library
> function should be used?
> 
> 5)I am trying to capture and play the same audio (ALSA duplex). When i
> capture and store it in a file and play from the file i am able to hear the
> sound properly. If i capture in a buffer and play the same buffer directly
> it says Broken PIPE ERROR in the playout.
>  I tried the capture and playout in two different threads, i am able to hear
> the sound and i am not getting any Broken PIPE error. But along with the
> audio i am hearing some noise.
> Do we need to use some kind of synchronisation between the threads for
> capture and playout?

I can't help here.


--
Giuliano.
