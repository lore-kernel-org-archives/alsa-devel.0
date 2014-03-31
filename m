From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] ALSA: usb-audio - Capture and duplex
 support for Digidesign Mbox 1 sound card.
Date: Mon, 31 Mar 2014 19:47:53 +0200
Message-ID: <5339AA49.6060906@zonque.org>
References: <52E5254A.8090308@gmail.com> <52E53D57.3010700@ladisch.de>
 <52E5CC2E.1010000@gmail.com> <5314EDA1.5040101@zonque.org>
 <1403282253300.13982@beth> <5336BC20.1050806@gmail.com>
 <1403292231190.1294@localhost> <53378DC2.3090603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 86071262618
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 19:47:54 +0200 (CEST)
In-Reply-To: <53378DC2.3090603@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Zammit <damien.zammit@gmail.com>, Mark Hills <mark@xwax.org>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hi Damien,

On 03/30/2014 05:21 AM, Damien Zammit wrote:
> On 30/03/14 09:57, Mark Hills wrote:
>> Thanks. I took a look and I think I have a similar concern to Daniel for 
>> readability. The code should really be shared with the quirk on a single 
>> endpoint.
> I guess a significant rewrite will be required.

Yeah, now that you changed the code to handle an arbitrary amount of
endpoints, you could as well change all user of
QUIRK_AUDIO_FIXED_ENDPOINT over to the new one, and initialize .epmulti
to 1. That should already work, right? (Though, I have to mention that
I'm unhappy with the name of that variable :)).

>> The duplicate code in the patch already has different handling of 
>> maxpacksize and datainterval -- is that intentional? It's apparent because 
>> the new code ignores the values given in the quirk.

That souldn't be the case then, of course.

> Not intentional, maxpacksize and datainterval happened to be identical
> for both endpoints on the Mbox.

So it's easy to change.

> Looking at the current struct for a snd_usb_audio_quirk:
> 
> struct snd_usb_audio_quirk {
>         const char *vendor_name;
>         const char *product_name;
>         int16_t ifnum;
>         uint16_t type;
>         const void *data;
> }
> 
> It is quite versatile, we shouldn't need to alter the quirk struct, just
> the data it holds.

A const void* can hold any kind of struct, and you need to cast it back
to your struct eventually anyway. Thinking about it again, I don't like
the idea of an extra member in struct snd_usb_audio_quirk either. What
would be nicer is to introduce something like this:

struct audioformats {
	unsigned int n_formats;
	const struct audioformat *format;
};

... and then define the quirk like this:

	.type = QUIRK_AUDIO_FIXED_MULTI_ENDPOINTS,
	.data = (const struct audioformats) {
		.n_formats = 2,
		.format = (const struct audioformat[]) {
			[0] = {
				.formats = SNDRV_PCM_FMTBIT_S24_3BE,
				...
			},
			[1] = {
				.formats = SNDRV_PCM_FMTBIT_S24_3BE,
				...
			},
		},
	}

IOW, encapsulate struct audioformat once more, so that the counter
variable is specific to this kind of quirk.

Also, you can write the actual quirk handler so that it loops over the
array entries, so you can re-use the code for both
QUIRK_AUDIO_FIXED_MULTI_ENDPOINTS and QUIRK_AUDIO_FIXED_ENDPOINT.

Do you follow? :)

>  Is an array of audioformats for this kind of
> interface the ideal choice?

Not sure whether I understand what you mean. Would be best to share a
patch that implements your idea.

> Also, maybe we can read bNumEndpoints to determine if it is a
> multi-endpoint interface and act accordingly, then we don't need an
> extra element in snd_usb_audio_quirk.

I think adding an array type is the best way to handle it.


Thanks,
Daniel
