From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: size of snd_hda_intel
Date: Tue, 7 Oct 2008 08:28:49 -0400
Message-ID: <9e4733910810070528t35b2e392xedd21d9247756388@mail.gmail.com>
References: <9e4733910810051519k427dce6aobca50815bfac30e2@mail.gmail.com>
	<fd3eb9bf0810060128y3af886e0m1ad2c39b0f9c78f1@mail.gmail.com>
	<9e4733910810061829h3f607e99s73857005e7ace514@mail.gmail.com>
	<s5hljx0okzp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 147BE2456B
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Oct 2008 14:29:02 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 9so710970qwj.56
	for <alsa-devel@alsa-project.org>; Tue, 07 Oct 2008 05:28:49 -0700 (PDT)
In-Reply-To: <s5hljx0okzp.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: =?ISO-8859-2?Q?Vedran_Mileti=E6?= <rivanvx@gmail.com>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2008/10/7 Takashi Iwai <tiwai@suse.de>:
> At Mon, 6 Oct 2008 21:29:32 -0400,
> Jon Smirl wrote:
>>
>> On Mon, Oct 6, 2008 at 4:28 AM, Vedran Mileti=E6 <rivanvx@gmail.com> wro=
te:
>> > I believe this isn't that easy. Here is why: iff you look at the
>> > ice1712/ice1724 driver, it doesn't detect dependencies when modprobed;
>> > that is, it loads, for example, ac97 codec and ak4xxx driver even if
>> > the card doesn't have any of that. Is it even possible to detect
>> > dependencies after modprobing?
>>
>> The base intel hda module would include code to figure out which codec
>> is attached. It can then use loadmodule() to dynamically load it. ASOC
>> use the separate codec driver model.
>
> You mean AOA?
> ASoC doesn't do any dynamic module handling by itself, AFAIK.

This lets you load another module from intel_hda:

        request_module("%s", module_name);


>> It would look like a "hda" bus in sysfs with the "codec" module sitting =
on it.
>
> Well, originally there shouldn't have been so many codec variants.
> The current situation came up due to a couple of obvious reasons...
>
> Ayway, the current plan is to develop an improved generic parser and
> add the capability to extra setup for each hardware, either
> dynamically or statically.  In that way, the whole static function
> callbacks and mixer arrays can be removed or replaced with smaller
> hints.
>
> The codec reconfigure patches are already in my tree in
> topic/hda-reconfig branch, and the improvement of generic parser is
> under development.
>
>
> Takashi
>
>
>> >
>> > 2008/10/6 Jon Smirl <jonsmirl@gmail.com>:
>> >>>ismod
>> >> snd_hda_intel         435,772
>> >>
>> >> 435,772 bytes seems awfully large for an audio driver. The large size
>> >> seems to be due to having support for multiple codecs in the driver.
>> >> Could a generic  hda driver load the correct codec dynamically instead
>> >> of building them all in statically?
>> >>
>> >> I have a Realtek codec.
>> >>
>> >> --
>> >> Jon Smirl
>> >> jonsmirl@gmail.com
>> >> _______________________________________________
>> >> Alsa-devel mailing list
>> >> Alsa-devel@alsa-project.org
>> >> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> >>
>> >
>> >
>> >
>> > --
>> > Vedran Mileti=E6
>> >
>>
>>
>>
>> --
>> Jon Smirl
>> jonsmirl@gmail.com
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>



-- =

Jon Smirl
jonsmirl@gmail.com
