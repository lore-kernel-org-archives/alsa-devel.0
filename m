From: vbs <vbs@springrts.de>
Subject: PCM params and Sub unit direction:Invalid argument
Date: Mon, 17 Oct 2016 00:07:25 +0200
Message-ID: <f844f202-7048-8794-d619-1493d586dd9c@springrts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay05.ispgateway.de (smtprelay05.ispgateway.de
 [80.67.31.94]) by alsa0.perex.cz (Postfix) with ESMTP id B4D57261560
 for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2016 00:07:28 +0200 (CEST)
Received: from [88.70.59.55] (helo=[192.168.2.21])
 by smtprelay05.ispgateway.de with esmtpa (Exim 4.84)
 (envelope-from <vbs@springrts.de>) id 1bvtaY-0007zT-Ax
 for alsa-devel@alsa-project.org; Mon, 17 Oct 2016 00:07:26 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello gentlemen,


I have a problem using libasound (1.1.0-0ubuntu1) in a program (Reicast 
emulator) with my system. When trying to initialize the ALSA device in 
the code by invoking "snd_pcm_hw_params" I get "Invalid argument". I 
stripped the problem down to a simple demo program:
http://pastebin.com/DMQrcYft

When I run it I get:
Unable to set hw parameters: Invalid argument

So the call to "snd_pcm_hw_params" fails on my system. I am using 
Lubuntu x64 16.04 on a NUC D54250.
This is my .asoundrc:
pcm.softvol {
     type            softvol
     slave {
         pcm         "hw:0,3"
     }
     control {
         name        "Master"
         card        0
     }
}

pcm.!default {
     type             plug
     slave.pcm       "softvol"
}

I created a softvol device to have a master volume mixer (some programs 
rely on it). This is the output of "aplay -L":
http://pastebin.com/k0qkfNnd

Two points I have noticed:
1. The problem disappears when not using the softvol device. When I 
replace my .asoundrc with this, then it works:
pcm.!default {
       type hw
       card 0
       device 3
  }
So the problems might be related to the defined softvol device.

2. In the sample program there is this code:
int dir;
         ...
rc=snd_pcm_hw_params_set_rate_near(handle, params, &val, &dir);

The variable dir is not initialized. But AFAIK that parameter in the 
function "snd_pcm_hw_params_set_rate_near" is also used as an input 
value. But the uninitialized variable will just have an undefined state. 
So this looks fishy to me.
When I change the definition to "int dir=0" then it actually works! With 
"int dir=1" the problem happens again.
I would think this is just a bug in the code but the strange thing is 
that the official example does it in the same way (calling 
"snd_pcm_hw_params_set_buffer_time_near" with an uninitialized dir 
variable):
http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2pcm_8c-example.html 
<http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2pcm_8c-example.html>
How can that unintialized variable be correct if it really is used as an 
input value?

Maybe someone has thoughts on this? Is the code correct? Especially 
regarding the unintialized variable?
Are there maybe problems with my .asoundrc softvol device?

Big thanks in advance guys!

Cheers,
Robin
