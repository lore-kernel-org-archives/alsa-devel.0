From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH v2 00/10] ALSA: usb-audio: fix
 playback/capture concurrent usage
Date: Thu, 22 Aug 2013 21:44:26 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308222144100.20668@heraclitus>
References: <1377121085-20563-1-git-send-email-eldad@fogrefinery.com>
 <5215AB8D.8020001@gmail.com> <alpine.LNX.2.00.1308221932490.1343@heraclitus>
 <52166854.2040208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f53.google.com (mail-bk0-f53.google.com
 [209.85.214.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F7D82608E9
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2013 21:44:34 +0200 (CEST)
Received: by mail-bk0-f53.google.com with SMTP id d7so858065bkh.40
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2013 12:44:33 -0700 (PDT)
In-Reply-To: <52166854.2040208@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org




On Thu, 22 Aug 2013, Daniel Mack wrote:

> On 22.08.2013 19:43, Eldad Zack wrote:
> > On Thu, 22 Aug 2013, Daniel Mack wrote:
> >> On 21.08.2013 23:37, Eldad Zack wrote:
> >>> Hi,
> >>>
> >>> This patch series attempts to fix a long starting problem with the concurrent
> >>> usage of playback and capture on implicit feedback devices.
> >>>
> >>> Applies against current for-next (HEAD b43dd416be21bc8ad60984e13def032f01aaaa18 ).
> >>
> >> Thanks a lot for working on this! I'll give that series a test run tonight.
> > 
> > That's great, thanks!
> 
> So, with your patches applied, I'm getting the NULL pointer Oops below
> just by plugging in a UAC2 sound card.
> 
> Note that on this system, pulseaudio is running and grabs the new card
> immediately, then closes it again. That might be different on your machine.
> 
> Do you want me to dig deeper or do you have an idea already?

Oh, I think that data_endpoint just doesn't get initialized yet, 
because it opens and closes immediately.

Does this fix it?

Cheers,
Eldad

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 02fb1ea..283e6c0 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1290,8 +1290,11 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream, int direction)
 		subs->interface = -1;
 	}
 
-	subs->data_endpoint->prepare_data_urb = NULL;
-	subs->data_endpoint->retire_data_urb = NULL;
+	if (subs->data_endpoint) {
+		subs->data_endpoint->prepare_data_urb = NULL;
+		subs->data_endpoint->retire_data_urb = NULL;
+	}
+
 	subs->pcm_substream = NULL;
 	snd_usb_autosuspend(subs->stream->chip);
 
