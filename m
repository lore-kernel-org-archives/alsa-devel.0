From: Arno Schuring <aelschuring@hotmail.com>
Subject: Re: RFC: ice1712 virtual devices
Date: Fri, 30 Oct 2009 12:29:21 +0100
Message-ID: <4AEACE11.1040500@hotmail.com>
References: <4AE9D57E.5090105@hotmail.com>
	<200910300923.37295.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-4.concepts.nl (smtp-4.concepts.nl [213.197.30.111])
	by alsa0.perex.cz (Postfix) with ESMTP id AA3E9244FB
	for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2009 12:29:30 +0100 (CET)
Received: from d594e6a3.dsl.concepts.nl ([213.148.230.163] helo=[172.22.21.58])
	by smtp-4.concepts.nl with esmtp (Exim 4.69)
	(envelope-from <aelschuring@hotmail.com>) id 1N3pfa-00048M-3T
	for alsa-devel@alsa-project.org; Fri, 30 Oct 2009 12:29:26 +0100
In-Reply-To: <200910300923.37295.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

[ I've trimmed the CC-list. Please let me know if the list policy
requires that I keep everybody personally CC'ed ]


Alan, Raymond,

Thanks for your comments. I'll remove the format conversion, and front:
will be a playback-only device. I do have to leave in the channel
conversion, otherwise front: will still require a 10-channel input.
Revised patch is at the bottom.


Alan Horstmann wrote:
[...]
> 
> Bear in mind that the ice1712 has been used on a number of very different 
> audio products aimed at different markets, from pro audio recording (DSP2000, 
> Delta1010) to desktop multi-media (DMX6fire, Aureon7.1) and so the 'best' 
> solution in each can be different.
Ouch. Should have seen that one coming :)

Ok, since at least the Aureon series do have defined surround-channels,
I will leave them in. Is there a particular reason why surround71 is
missing, or can I add it safely to the config?


>> Finally, I'm also experimenting with the dshare plugin to allow
>> applications to access the iec958: and front: devices simultaneously.
>> Can anyone point me to a working example for this? From reading the
>> alsa-lib documentation, it is not clear to me how I should nest the
>> different plugins.

I've come a little further with this now, and I can get simultaneous
output on both front: and iec958: devices. There is just one issue left,
I can't find a way to let the hooks plugin play nicely with the dshare
plugin. My current config looks like this:

ICE1712.pcm.iec958.0 {
   type asym
   playback.pcm {
      type hooks
      slave.pcm {
         type dshare
         ipc_key 10203  #testing only
         slave.pcm {
            type hw
            card $CARD
         }
         slave.channels 10
         bindings {
            0 8
            1 9
         }
      }
      #hooks.0 {
         #type ctl_elems
         #hook_args [
            #{
               #interface PCM
               #name "IEC958 Playback PCM Stream"
               #lock true
               #preserve true
               #value [ $AES0 $AES1 $AES2 $AES3 ]
            #}
         #]
      #}

If I enable the hooks.0 section, I get the following error from aplay:

aschuring@neminis:~$ aplay -v -D iec958:0 alsa/Noise.wav
ALSA lib pcm_hooks.c:678:(_snd_pcm_hook_ctl_elems_install) No card for
this PCM
aplay: main:608: audio open error: Invalid argument


And if I change the nesting order for hooks and dshare, I get the following:

aschuring@neminis:~$ aplay -v -D plug:iec958:0 alsa/Noise.wav
ALSA lib pcm_dshare.c:711:(snd_pcm_dshare_open) dshare plugin can be
only connected to hw plugin
Segmentation fault


I'm really not familiar with the ctl_elems hook, and I'm hoping that
there is a simple fix by changing the parameters for it. Can anyone
point me in the right direction?


Thanks again,
Arno

--
diff --git a/src/conf/cards/ICE1712.conf b/src/conf/cards/ICE1712.conf
index 01e50d2..1cd3773 100644
--- a/src/conf/cards/ICE1712.conf
+++ b/src/conf/cards/ICE1712.conf
@@ -32,12 +32,16 @@ ICE1712.pcm.front.0 {
        @args.CARD {
                type string
        }
-       type route
-       ttable.0.0 1
-       ttable.1.1 1
-       slave.pcm {
-               type hw
-               card $CARD
+       type asym
+       playback.pcm {
+               type route
+               ttable.0.0 1
+               ttable.1.1 1
+               slave.pcm {
+                       type hw
+                       card $CARD
+               }
+               slave.channels 10
        }
 }
