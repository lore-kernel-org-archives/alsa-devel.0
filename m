From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio - Capture and duplex
 support for Digidesign Mbox 1 sound card.
Date: Tue, 01 Apr 2014 13:41:29 +1100
Message-ID: <533A2759.8070609@gmail.com>
References: <52E5254A.8090308@gmail.com> <52E53D57.3010700@ladisch.de>
 <52E5CC2E.1010000@gmail.com> <5314EDA1.5040101@zonque.org>
 <1403282253300.13982@beth> <5336BC20.1050806@gmail.com>
 <1403292231190.1294@localhost> <53378DC2.3090603@gmail.com>
 <5339AA49.6060906@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com
 [209.85.192.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EDBC2651CF
 for <alsa-devel@alsa-project.org>; Tue,  1 Apr 2014 04:42:13 +0200 (CEST)
Received: by mail-pd0-f175.google.com with SMTP id x10so8768242pdj.6
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 19:42:11 -0700 (PDT)
In-Reply-To: <5339AA49.6060906@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, Mark Hills <mark@xwax.org>
List-Id: alsa-devel@alsa-project.org

On 01/04/14 04:47, Daniel Mack wrote:
> Yeah, now that you changed the code to handle an arbitrary amount of
> endpoints, you could as well change all user of
> QUIRK_AUDIO_FIXED_ENDPOINT over to the new one, and initialize .epmulti
> to 1. That should already work, right? (Though, I have to mention that
> I'm unhappy with the name of that variable :)).
Given Mark's concerns, I'm not sure this will work for devices which
share an interface with multiple endpoints where the endpoints have
different properties.  I think my code only works when the multiple
endpoints have the same properties apart from the endpoint #.

For example, the existing code which brings up a fixed interface assumes
that there is only one endpoint and refers to it via an index which is
usually hardcoded to 0.  So most of the quirk would be ignored as only
the data for the first mentioned endpoint would be used for certain
functions.
For example, functions such as get_endpoint(alts, 0) etc.  This is the
major stumbling block that Mark is referring to I think.  What are your
thoughts on this one Daniel?  Have you seen Mark's untested code?  It's
part of this thread and seems to address this problem.

> A const void* can hold any kind of struct, and you need to cast it back
> to your struct eventually anyway. Thinking about it again, I don't like
> the idea of an extra member in struct snd_usb_audio_quirk either. What
> would be nicer is to introduce something like this:
> 
> struct audioformats {
> 	unsigned int n_formats;
> 	const struct audioformat *format;
> };
Yes, this looks good, I can use this idea.

> Also, you can write the actual quirk handler so that it loops over the
> array entries, so you can re-use the code for both
> QUIRK_AUDIO_FIXED_MULTI_ENDPOINTS and QUIRK_AUDIO_FIXED_ENDPOINT.
> 
> Do you follow? :)
Yes, it makes sense.
