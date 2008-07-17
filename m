From: stan <ghjeold_i_mwee@cox.net>
Subject: Re: Setting format to SND_PCM_FORMAT_MU_LAW does not
 let	me apply hardware parameters
Date: Wed, 16 Jul 2008 20:30:06 -0700
Message-ID: <487EBCBE.70504@cox.net>
References: <3B6F5C9068D5864096EB291236C3386F02CE1659@xmb-sjc-21d.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao105.cox.net (fed1rmmtao105.cox.net [68.230.241.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 8439024415
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jul 2008 05:30:08 +0200 (CEST)
In-Reply-To: <3B6F5C9068D5864096EB291236C3386F02CE1659@xmb-sjc-21d.amer.cisco.com>
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

> 
> I am making some changes to the alsa-lib code and I have built alsa-lib. But I don't think its really picking up my changes. How can I make sure that my application uses the 
modified library? I don't have to load any modules, do 
I? I am sorry if this is too basic a question but I 
couldn't find the info on a quick google search. 
Basically what I want to know is what are the steps to 
develop alsa-lib. This is what I did
> 1) Downloaded the source code
> 2) Configured the system using ./configure
> 3) Did a build using make
> 4) Did a "make install"
> 
> Am I missing something here? 

It looks correct.  Do an   ls -l /usr/lib/libasound*. 
The file there should have the same timestamp as the 
file in your build directory.  If it doesn't, it didn't 
install.  You could just copy it over.

Make sure there is no other copy in /lib.

> 
> Also regarding the original problem, when I run my program, the output of /proc/asound/card0/pcm0p/sub0/hw_params is
> 
> access: MMAP_INTERLEAVED
> format: S16_LE
> subformat: STD
> channels: 2
> rate: 48000 (48000/1)
> period_size: 32
> buffer_size: 1024
> 
> This is clearly not what it should be since the data access should be RW_NONINTERLEAVED, format should be MU_LAW, there is only one channel and rate is 8000. Which would mean that alsa assumes a different set of parameters (for mu law)from what the data actually is. Am I right in thinking this?
> 
> Just got back after a long break and trying to pick up the threads again:-)
> 
> Again, any help will be much appreciated.
> 
> 
> 

Unless your changes changed the mu-law code to use your 
card's mu-law decoder, they will still be the decoded 
values.

The best way to do this is to compile your program with 
debugging enabled (  -ggdb  -O0) and the alsa library 
with debugging enabled.  ./configure  --help should 
give you the option.  Then move only the library to 
/usr/lib and run your program as
gdb --args yourprogram yourargs   .  You can see the 
info on how to run gdb in  info gdb  .  With the 
debugger you can step through the program and the 
library to see where it is not working the way you 
expected.  But you don't want to leave it like that as 
it is very inefficient.

If your code works for the mu-law, you could submit a 
patch.  Of course, you would have to check for the 
functionality and branch to the old code if the card 
doesn't support mu-law decoding.
