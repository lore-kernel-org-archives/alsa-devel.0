From: "Olivier Guillion - Myriad" <olivier@myriad-online.com>
Subject: Re: ALSA calls don't work within  Mozilla plug-ins
Date: Tue, 23 Aug 2011 15:09:27 +0200
Message-ID: <4E53A687.12567.14A3850@olivier.myriad-online.com>
References: <4E538D63.13402.E803A1@olivier.myriad-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.planet-service.fr (smtp.planet-service.fr [83.167.45.85])
	by alsa0.perex.cz (Postfix) with ESMTP id 5753310382B
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 15:09:12 +0200 (CEST)
In-reply-to: <4E538D63.13402.E803A1@olivier.myriad-online.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi again,

I investigated a bit further, and experienced a strange behaviour on other 
function calls, that could be a clue to understand what happens.

When trying to use the default PCM output, functions like 
snd_pcm_hw_params_get_buffer_size don't work as expected when called from 
within the Mozilla plug-in.

For instance:

val=12345;
err=snd_pcm_hw_params_get_buffer_time(hwparams,&val,NULL);

should return: err=0 , val=time previously set

>From within the plugin, it returns:
err=733007751
val remains unchanged (12345).

I took a look at the ALSA source code and I can't figure out how the "val" 
parameter can remain untouched.

Any idea?

Olivier

---- Original message ----

> I'm trying to develop a Mozilla plug-in that display and plays music scores. The
> music rendering module uses ALSA for sound (pcm) output.
> 
> It seems that, when called from a Mozilla plug-in, any ALSA function that gets a
> pointer as parameter either crashes or returns wrong values.
> 
> I made a very simple test plug-in from the "Basic Plugin" source code provided
> by Mozilla (I can provide the full project if needed). Here is what happens:
> 
> - Calling "snd_asoundlib_version" works
> 
> - Calling "snd_device_name_hint" crashes
> 
> - If the browser runs in super-user mode (sudo firefox), all works fine.
> 
> - If I load the plug-in (which is a shared library) from a program of my own and
> call the test function, it works.
> 
> Does anyone have any idea about what could cause this issue?
> Could it be related to access rights or memory allocation/mapping?
> 
> I'm using: 
> Ubuntu 11.04
> Firefox 6.0
> ALSA 1.0.24.1
> 
> I'm really stuck here, any advice would be highly appreciated.
> Thank you,
> Olivier
