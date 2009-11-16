From: Arno Schuring <aelschuring@hotmail.com>
Subject: Re: RFC: ice1712 virtual devices
Date: Mon, 16 Nov 2009 20:32:28 +0100
Message-ID: <4B01A8CC.6050303@hotmail.com>
References: <4AE9D57E.5090105@hotmail.com>	<200910300923.37295.gineera@aspect135.co.uk>	<s5h3a4pqp1c.wl%tiwai@suse.de>
	<200911082113.17684.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-4.concepts.nl (smtp-4.concepts.nl [213.197.30.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 286C7245DE
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 20:32:39 +0100 (CET)
In-Reply-To: <200911082113.17684.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello again,

Alan Horstmann wrote:
> On Sunday 08 November 2009 10:38, you wrote:
>> At Fri, 30 Oct 2009 09:23:37 +0000,
>>
>> Alan Horstmann wrote:
>>> On Thursday 29 October 2009 17:48, Arno Schuring wrote:
>>>> This is basically a resend of
>>>> http://thread.gmane.org/gmane.linux.alsa.devel/59481/focus=59672 ,
>>>> which fixed the front: device of ice1712 cards to accept two-channel
>>>> input. Currently, the front: device is exposed through the route
>>>> plugin, which requires all clients to mmap all 10 channels, even though
>>>> the front device is supposed to be a stereo device.
[...]
> 
> Arno's original post was just to the list, so I added your cc.  His response 
> was also only to the list, but has a patch at the bottom to do just playback 
> asym with channels convertion, (which looks reasonable to me), so might be 
> worth looking back at.
> 
> BTW, for example in the case of ice1712, is there a way for different sound 
> cards which use the same driver to have different default config files?  The 
> DMX6fire in particular would benefit from specific definitions for the 
> particular mapping of its 6 analogue inputs.

I apologize for the long delay. I'll reattach my latest proposed patch
(copy-paste, hope it still applies).

About my second question, is it even worth my time to try to implement
multiple separate devices using the dshare plugin? I mean, even if I
succeed in making front: and spdif: working together, does such a patch
have even the slightest of getting accepted?


Thanks,
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
