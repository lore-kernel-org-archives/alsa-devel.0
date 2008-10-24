From: "Nir Tzachar" <nir.tzachar@gmail.com>
Subject: Re: Nvidia hdmi problems
Date: Fri, 24 Oct 2008 13:33:17 +0200
Message-ID: <9b2db90b0810240433u8bd54d1x3ec2f09629aadc65@mail.gmail.com>
References: <9b2db90b0810200735g61cad43dr538c3afc495398ec@mail.gmail.com>
	<s5hy70hyx2j.wl%tiwai@suse.de>
	<9b2db90b0810221009v36039a7eu4564c15d79433823@mail.gmail.com>
	<s5h7i7z8l2a.wl%tiwai@suse.de>
	<9b2db90b0810231134t6e3e10h99df8b3bb183741f@mail.gmail.com>
	<s5h7i7z3smz.wl%tiwai@suse.de>
	<9b2db90b0810231308r51a4ee22s103f78cd5782d440@mail.gmail.com>
	<s5htzb2e9lr.wl%tiwai@suse.de>
	<9b2db90b0810240032o4439b48dn47b67ba708f03e77@mail.gmail.com>
	<s5h4p32s4qs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 973AB244B8
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 13:33:35 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so496070yxh.2
	for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2008 04:33:17 -0700 (PDT)
In-Reply-To: <s5h4p32s4qs.wl%tiwai@suse.de>
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
Cc: Wei Ni <wni@nvidia.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 24, 2008 at 11:48 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 24 Oct 2008 09:32:43 +0200,
> Nir Tzachar wrote:
>>
>> On Fri, Oct 24, 2008 at 9:27 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Thu, 23 Oct 2008 22:08:15 +0200,
>> > Nir Tzachar wrote:
>> >>
>> >> On Thu, Oct 23, 2008 at 11:31 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> >> > At Thu, 23 Oct 2008 20:34:30 +0200,
>> >> > Nir Tzachar wrote:
>> >> >>
>> >> >> On Thu, Oct 23, 2008 at 10:04 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> >> >> > At Wed, 22 Oct 2008 19:09:41 +0200,
>> >> >> > Nir Tzachar wrote:
>> >> >> >>
>> >> >> >> On Wed, Oct 22, 2008 at 8:15 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> >> >> >> > At Wed, 22 Oct 2008 06:43:06 +0200,
>> >> >> >> > Nir Tzachar wrote:
>> >> >> >> >>
>> >> >> >> >> On Wed, Oct 22, 2008 at 4:42 AM, Wei Ni <wni@nvidia.com> wrote:
>> >> >> >> >> > Hi, Takshi
>> >> >> >> >> > We have no official plan to support this nforce 630i HDMI audio in linux
>> >> >> >> >> > now,
>> >> >> >> >> > and we didn't do any test on it yet. So we can't provide the official
>> >> >> >> >> > patch for this addition.
>> >> >> >> >> >
>> >> >> >> >> > I think if someone interest in it and do some test, he can generate
>> >> >> >> >> > patch and submit it.
>> >> >> >> >>
>> >> >> >> >> As I am interested, and willing o do the tests, I would be happy to
>> >> >> >> >> know which tests are needed.
>> >> >> >> >
>> >> >> >> > If you can play both audio streams and non-audio streams over the device
>> >> >> >> > by some applications, it's basically confirmed to work :)
>> >> >> >>
>> >> >> >> What do you mean by non-audio stream?
>> >> >> >
>> >> >> > The passthrough of AC3 stream or so.
>> >> >> >
>> >> >> >> Can you give specific commands
>> >> >> >> which should work?
>> >> >> >
>> >> >> > I usually test using ac3dec program included in alsa-tools.
>> >> >>
>> >> >> Tried  ac3decode, and got a perfect sound out. I am using the
>> >> >> following asound.conf (if it is relevant):
>> >> >
>> >> > Well, I guess this won't be a non-audio mode.
>> >> > Try to get the latest alsa-tools git tree.  I changed ac3dec and
>> >> > now it has -H option.  Specify this together with -C,
>> >> >
>> >> >        % ac3dec -C -H foo.ac3
>> >> >
>> >> > This will be the AC3 passthru testing.
>>
>> This is the only one that works:
>>
>> ./ac3dec -R --hdmi /tmp/ac3_the_other_side_48khz.ac3
>> 5.1 Mode 48.0 KHz 640 kbps Complete Main Audio Service
>> Using PCM device 'plug:hdmi:{AES0 0x0 AES1 0x82 AES2 0x0 AES3 0x2}'
>>
>> -P and -C give me a strange mewling..
>>
>> BTW, -H does not work, only --hdmi.
>
> The patch below should fix the missing -H option.
>
> With the option -R, ac3dec itself decodes the AC3 stream, and send
> it as PCM.  To make your receiver decoding AC3, -C/-P is needed.
>
> Can you show alsa-info.sh output (with --no-upload option)?
> If you have two "IEC958 Playback Default" controls with index 0 and 1,
> the latter is likely the one for HDMI.
>
> Try to adjust it manually via iecset program in alsa-utils
>        % iecset -c0 -n1 pro off audio off
> then run ac3dec
>        % ac3dec -H -C foo.ac3

I don't get any sound (at all, not even regular pcm) after doing this.
Maybe my TV is not capable of ac3 input? Is this possible?

>
> thanks,
>
> Takashi
>
> diff --git a/ac3dec/ac3dec.c b/ac3dec/ac3dec.c
> index c45148c..293a95c 100644
> --- a/ac3dec/ac3dec.c
> +++ b/ac3dec/ac3dec.c
> @@ -134,7 +134,7 @@ int main(int argc,char *argv[])
>        while (1) {
>                int c;
>
> -               if ((c = getopt_long(argc, argv, "hvc:D:46CPRZ:q", long_option, NULL)) < 0)
> +               if ((c = getopt_long(argc, argv, "hvc:D:46HCPRZ:q", long_option, NULL)) < 0)
>                        break;
>                switch (c) {
>                case 'h':
>
