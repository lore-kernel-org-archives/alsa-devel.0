From: Daniel Mack <zonque@gmail.com>
Subject: Re: [Alsa-user] Ticks when playing to USB DAC at high
	sample rates
Date: Thu, 22 Nov 2012 20:29:05 +0100
Message-ID: <50AE7D01.4070101@gmail.com>
References: <3884466.olklcBH31l@quintet> <9872736.seOqKZ7sS2@quintet>
 <509A235A.7000004@gmail.com> <1427406.0H8zTTgyKy@quintet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 2451B260376
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 20:29:12 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so3416792bkc.38
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 11:29:11 -0800 (PST)
In-Reply-To: <1427406.0H8zTTgyKy@quintet>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeffrey Barish <jeff_barish@earthlink.net>
Cc: alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Jeffrey,

sorry for the late reply.

On 08.11.2012 19:54, Jeffrey Barish wrote:
> On Wed 07 November 2012 10:01:14 Daniel Mack wrote:
>> On 07.11.2012 00:54, Jeffrey Barish wrote:
>>> I guess that snd_usb_pcm_prepare is called by the core usb system to
>>> prepare the snd driver.  Anyway, snd_usb_pcm_prepare calls
>>> configure_endpoint with a substream.  Then configure_endpoint calls
>>> snd_usb_endpoint_set_params with the data endpoint that corresponds to
>>> the substream.  snd_usb_endpoint_set_params calls data_ep_set_params with
>>> the data ep and data_ep_set_params sets nurbs to 2 for the data endpoint.
>>>
>>> snd_usb_endpoint_set_params has code to call sync_ep_set_params when the
>>> endpoint is type sync.  sync_ep_set_params sets nurbs to 4 (why?). 
>>> However, snd_usb_endpoint_set_params never invokes the call to
>>> sync_ep_set_params because ep->type is always data.  Back up:
>>> snd_usb_endpoint_set_params is called from configure_endpoint.  It is
>>> called from an if block contingent on the substream's having a sync
>>> endpoint.  It does.  However, the call to snd_usb_endpoint_set_params
>>> passes subs->data_endpoint as the first argument, so
>>> snd_usb_endpoint_set_params simply repeats the operations it performed as
>>> a result of the previous invocation.  I presume that the first argument
>>> to the second call to snd_usb_endpoint_set_params should be
>>> subs->sync_endpoint.
>> Eh. You clearly spotted a bug here. The rally interesting thing is that
>> that it didn't bite us earlier, as it's in since 3.6.
> 
> Here's the diff.  I can't figure out how to submit a patch.
> 
> --- sound/usb/pcm.c.orig        2012-11-08 11:43:57.309732860 -0700
> +++ sound/usb/pcm.c     2012-11-08 11:41:06.512420658 -0700
> @@ -456,7 +456,7 @@ static int configure_endpoint(struct snd
>                 return ret;
>  
>         if (subs->sync_endpoint)
> -               ret = snd_usb_endpoint_set_params(subs->data_endpoint,
> +               ret = snd_usb_endpoint_set_params(subs->sync_endpoint,
>                                                   subs->pcm_format,
>                                                   subs->channels,
>                                                   subs->period_bytes,

Thanks - I just sent out a patch for this.



Daniel
