From: Ben C <bchang_2@yahoo.com>
Subject: Re: snd_pcm_hw_params_get_xxx question
Date: Wed, 7 Nov 2007 16:16:48 -0800 (PST)
Message-ID: <453252.40402.qm@web36512.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web36512.mail.mud.yahoo.com (web36512.mail.mud.yahoo.com
	[209.191.85.12]) by alsa0.perex.cz (Postfix) with SMTP id C2C67246E0
	for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2007 01:16:50 +0100 (CET)
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

Takashi,

You were right, it was a linking issue. I'm doing cross-compiling for a target of different processor type. I just had to make sure I'm pointing to the right location for the includes and libs.

Thanks,
Ben

----- Original Message ----
From: Takashi Iwai <tiwai@suse.de>
To: Ben C <bchang_2@yahoo.com>
Cc: alsa-devel@alsa-project.org
Sent: Wednesday, November 7, 2007 4:24:04 AM
Subject: Re: [alsa-devel] snd_pcm_hw_params_get_xxx question


At Tue, 6 Nov 2007 18:21:01 -0800 (PST),
Ben C wrote:
> 
> Hello,
> 
> I'm trying to develop an external PCM plugin. I'm calling
 snd_pcm_hw_params_get_xxx functions to retrieve some values. I got everything to
 work as expected on alsa-lib 1.0.15. However the client's setup is
 1.0.13, and I don't think they want to upgrade.
> 
> For 1.0.13, everything compiled and linked fine after some minor
 changes. But when I called say snd_pcm_hw_params_get_rate(hw, &val, &dir),
 I was expecting the return value to be a status, and val to contain
 "44100" which was the case for 1.0.15. However for 1.0.13, val is 0, but
 returned status = 44100?
> 
> I looked in the header files, and 1.0.13 seems to be the same as
 1.0.15 in regards to this function. Am I accidentally using some sort of
 old API that was intended for backward compatibility? If so, what should
 I do to use the "new" API's?

Yes, it sounds like you're accessing the old API.  Do you use
libasound from a module?  If it's used from a module, the module
itself should be built once with link to libasound.  For example,
    $(CC) -shared -o MODULE.so -lasound
In such a way, the properly versioned symbol is chosen.  The weak link
results in the old API.  This is irrelveant whether it's ALSA 1.0.13
or 1.0.15.


Takashi





__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
