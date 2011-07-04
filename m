From: Daniel Mack <zonque@gmail.com>
Subject: Re: M-Audio FTU issues
Date: Mon, 4 Jul 2011 19:23:28 +0200
Message-ID: <CACTFLAO1T=Top4SpZ-1r+tw_b7pUqVOi7QDHr4sFa6POrRY8zw@mail.gmail.com>
References: <BANLkTimOjiKwOqSveGvujMJ5uBL-JKsBeA@mail.gmail.com>
	<4E045058.6000405@showlabor.de>
	<BANLkTi=Bj7DFbSFs9p1go-ACzCAtZ=ij6w@mail.gmail.com>
	<4E04B42E.2080906@ladisch.de>
	<BANLkTinurcpMuPe-99GsaxWk+pF-K4Z_7Q@mail.gmail.com>
	<BANLkTik+2+WeOH+rcd83g63pq6asxtLAGQ@mail.gmail.com>
	<BANLkTimz6FPFFmw+-BcmP0jzyy3=gvjcVw@mail.gmail.com>
	<CACckToXFevhAHt_jC9P=ifZ9X0KVT1S7-KQnrcSna_ineeSyZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B6F20103868
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jul 2011 19:23:30 +0200 (CEST)
Received: by pvg18 with SMTP id 18so6181178pvg.38
	for <alsa-devel@alsa-project.org>; Mon, 04 Jul 2011 10:23:28 -0700 (PDT)
In-Reply-To: <CACckToXFevhAHt_jC9P=ifZ9X0KVT1S7-KQnrcSna_ineeSyZg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

On Sun, Jul 3, 2011 at 1:52 PM, Grant Diffey <gdiffey@gmail.com> wrote:
>> I'd like to discuss the API for the ALSA/USB decoupling as suggested
>> by Clemens, which will solve this problem then.
>
>
> Nobody has any ideas what this interface might look like?
>
> From what I understand this would lead to re-unifying the ua101 driver into
> snd-usb-audio as well?

As I've said, my understanding of the USB audio standard covers a
feedback model for which the capture stream implicitly defines the
pace the driver is supposed to deliver audio samples to the playback
endpoint (most devices do have sync endpoint for that). Considering
that, there might be more devices coming up which do it that way, and
we should have support for this model in the generic driver IMO.

So at least, my patch shows that it's not too hard to support it, and
we just need a way to sort out how to incorporate the new logic in a
way that it doesn't break the concept of the generic driver. Let me
think about it for some more days. In the meantime, it sounded like
Clemens already brooded on that topic for FireWire devices, and it
might make sense to benefit from the results (and keep the API
similar).


Daniel
