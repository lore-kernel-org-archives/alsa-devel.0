From: "Olivier Guillion - Myriad" <olivier@myriad-online.com>
Subject: Re: [Closed]ALSA calls don't work from a shared library
Date: Thu, 25 Aug 2011 17:31:42 +0200
Message-ID: <4E566ADE.23346.1D5309C@olivier.myriad-online.com>
References: <4E54E228.12224.FC4C70@olivier.myriad-online.com>,
	<4E54E3A1.5090702@perex.cz>,
	<4E5510DB.29995.1B2B612@olivier.myriad-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.planet-service.fr (smtp.planet-service.fr [83.167.45.85])
	by alsa0.perex.cz (Postfix) with ESMTP id BC85124549
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Aug 2011 17:31:29 +0200 (CEST)
In-reply-to: <4E5510DB.29995.1B2B612@olivier.myriad-online.com>
Content-description: Mail message body
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I could finally make it work:
- The library corruption problem was due to a faulty symbolic link to an 
outdated library.
- I could fix the linker problem by including "/usr/lib/libasound.so.2" in my 
link options
- I still got an error sometimes on "snd_async_add_pcm_handler" but I replaced 
it by a second thread that fills the pcm buffer when needed.
- The only remaining problem is "snd_device_name_hints" that crashes 
inexplicably one out of 5, but I'm working on it.

Thanks for your help!

Olivier


I wrote:
> 
> Thank you very much for your answer!
> I agree, it's definitely a link problem. 
> 
> If my main module sends the addresses of the ALSA functions to the shared 
> library, the test works.
> It then means that the shared library by itself doesn't know the right location
> of the functions, and that there is a problem during the run-time link.
> 
> It has then nothing to do with ALSA, but in my way of managing libraries. :) I
> have 15 years of experience in C, but only a couple of months on Linux, and
> sometimes I'm a bit lost.
> 
> To make ALSA work in my projects (I'm using Code:Blocks), I added to the link
> section all the .so libraries I found in /usr/lib/alsa-lib. Apparently it worked
> for stand-alone programs, but not for shared libraries.
> 
> Could you please tell me what I should add to my project (I'm using 
> Code:Blocks) to make my programs use the current ALSA shared library in the
> system? I tried to build the static lib (./configure --enable-makeshared=no --
> enable-static=yes) then the shared lib (./configure --enable-makeshared=no --
> enable-static=yes) but it seems to have corrupted my system. My already compiled
> old programs don't work anymore, saying that "snd_async_add_pcm_handler" is not
> implemented.
> 
> Sorry if my request is out of the topic of this mailing-list. Please do not
> hesitate to tell me if so.
