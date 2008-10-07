From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: size of snd_hda_intel
Date: Mon, 6 Oct 2008 21:29:32 -0400
Message-ID: <9e4733910810061829h3f607e99s73857005e7ace514@mail.gmail.com>
References: <9e4733910810051519k427dce6aobca50815bfac30e2@mail.gmail.com>
	<fd3eb9bf0810060128y3af886e0m1ad2c39b0f9c78f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.146])
	by alsa0.perex.cz (Postfix) with ESMTP id B10891037F1
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Oct 2008 03:29:46 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 9so652241qwj.56
	for <alsa-devel@alsa-project.org>; Mon, 06 Oct 2008 18:29:32 -0700 (PDT)
In-Reply-To: <fd3eb9bf0810060128y3af886e0m1ad2c39b0f9c78f1@mail.gmail.com>
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
To: =?ISO-8859-2?Q?Vedran_Mileti=E6?= <rivanvx@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 6, 2008 at 4:28 AM, Vedran Mileti=E6 <rivanvx@gmail.com> wrote:
> I believe this isn't that easy. Here is why: iff you look at the
> ice1712/ice1724 driver, it doesn't detect dependencies when modprobed;
> that is, it loads, for example, ac97 codec and ak4xxx driver even if
> the card doesn't have any of that. Is it even possible to detect
> dependencies after modprobing?

The base intel hda module would include code to figure out which codec
is attached. It can then use loadmodule() to dynamically load it. ASOC
use the separate codec driver model.

It would look like a "hda" bus in sysfs with the "codec" module sitting on =
it.

>
> 2008/10/6 Jon Smirl <jonsmirl@gmail.com>:
>>>ismod
>> snd_hda_intel         435,772
>>
>> 435,772 bytes seems awfully large for an audio driver. The large size
>> seems to be due to having support for multiple codecs in the driver.
>> Could a generic  hda driver load the correct codec dynamically instead
>> of building them all in statically?
>>
>> I have a Realtek codec.
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
>
>
> --
> Vedran Mileti=E6
>



-- =

Jon Smirl
jonsmirl@gmail.com
