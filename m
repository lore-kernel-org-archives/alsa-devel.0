From: stan <ghjeold_i_mwee@cox.net>
Subject: Re: Setting format to SND_PCM_FORMAT_MU_LAW does not
 let	me apply hardware parameters
Date: Wed, 23 Jul 2008 11:25:54 -0700
Message-ID: <488777B2.1060608@cox.net>
References: <3B6F5C9068D5864096EB291236C3386F02CE1663@xmb-sjc-21d.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao102.cox.net (fed1rmmtao102.cox.net [68.230.241.44])
	by alsa0.perex.cz (Postfix) with ESMTP id 216B4247FB
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jul 2008 20:25:56 +0200 (CEST)
In-Reply-To: <3B6F5C9068D5864096EB291236C3386F02CE1663@xmb-sjc-21d.amer.cisco.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Mitul Sen (misen)" <misen@cisco.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mitul Sen (misen) wrote:
> Hi, 
> 
> I have tried using gdb both from the command line as you suggested and
> also from within eclipse. Even though I can step through the code and
> break properly, I think there is some mismatch between the source code
> and object code used by gdb. I say that because it sometimes steps
> through code in a way that makes no sense. For example, I see that a
> particular 'if' condition is satified and it goes into the 'if' clause
> and then again goes into the 'else' clause that is not expected. Is
> there any module that needs to be reloaded after building and installing
> the shared library? I have done a clean make at all times, checked
> timestamps, even rebooted the machine in case some driver related data
> needs to be reloaded at startup but none of this has helped.
I suspect you are debugging optimized code.  The 
optimizer rearranges and deletes instructions.  Did you 
specify -O0 so that no optimization occurs?  The other 
gotcha in the alsa-lib code is that some of the 
functions are actually macros.  They cannot be stepped 
through.  When you hit them in the debugger it is 
disconcerting.
> 
> Another thing that I notice is that when I use aplay to play the rtp
> data that I save to file (before writing to the sound device), and check
> the output of /proc/asound/card0/pcm0p/sub0/hw_params file, it is
> exactly the same as when I run my application. Using aplay does the
> playback properly even though hw_params still shows as
> 
> access: MMAP_INTERLEAVED
> format: S16_LE
> subformat: STD
> channels: 2
> rate: 48000 (48000/1) 
It is decoding it before it is playing it, it must be 
calling a routine somewhere to do that, or else it is 
built in.
> 
> Please note that I can play back the file using aplay, I only have the
> problem of bad audio when I try to write to the sound device in
> real-time. With this observation though I am not sure if the fact that
> the library seems to not use the card's decoder is really the problem. I
> am trying to look into the source code of aplay to see if I can spot any
> difference in the way the data is written to the buffer.
> 
Good not to limit the possibilities you are examining.
> Meanwhile, any comments and help will be greatly appreciated as usual.
> 
> Thanks for your help.
> 
> Regards,
> Mitul
> 
