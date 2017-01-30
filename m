From: Detlef Urban <onkel@paraair.de>
Subject: Re: [PATCH 1/1] ALSA: Tascam US-16x08 DSP mixer quirk
Date: Mon, 30 Jan 2017 13:08:40 +0100
Message-ID: <aa4b05a1-c915-1555-80d2-c445d57265c0@paraair.de>
References: <c16a71d1-d3fe-fcc2-d74d-28f8eca6b932@paraair.de>
 <s5hd1fajf9t.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 201EE2667CC
 for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2017 13:08:42 +0100 (CET)
In-Reply-To: <s5hd1fajf9t.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Here my review on your reply.


> Through a quick glance, the patch doesn't seem to follow the standard
> coding style.  Please reformat all in a style defined in
> Documentation/process/coding-style.rst (or formerly
> Documentation/CodingStyle).
Fixed.

> Also, you seem using some global variables.  These are broken if you
> have multiple devices.  That is, they have to be allocated
> dynamically.
Fixed.

> Currently we have no private data field assigned to either usb audio
> card or mixer object, so we'll need a preliminary patch to add it
> beforehand.

I can't agree with that.
In all cases the private data field I make use of is member of
struct usb_mixer_elem_info. To me it seems to be a common approach
to store device specific handling data. Please correct me if I'm wrong.

thanks,

Detlef


Am 26.01.2017 um 11:18 schrieb Takashi Iwai:
> On Thu, 26 Jan 2017 09:37:23 +0100,
> Detlef Urban wrote:
>> Add mixer quirk for Tascam US-16x08 usb interface.
>> Even that this an usb compliant device,
>> the input channels and DSP functions (EQ/Compressor)
>> arn't accessible by default.
>>
>> Signed-off by: Detlef Urban <onkel@paraair.de>
> Through a quick glance, the patch doesn't seem to follow the standard
> coding style.  Please reformat all in a style defined in
> Documentation/process/coding-style.rst (or formerly
> Documentation/CodingStyle).
>
> Also, you seem using some global variables.  These are broken if you
> have multiple devices.  That is, they have to be allocated
> dynamically.
>
> Currently we have no private data field assigned to either usb audio
> card or mixer object, so we'll need a preliminary patch to add it
> beforehand.
>
>
> thanks,
>
> Takashi
