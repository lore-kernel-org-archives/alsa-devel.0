From: "Nir Tzachar" <nir.tzachar@gmail.com>
Subject: Re: Nvidia hdmi problems
Date: Fri, 24 Oct 2008 09:32:43 +0200
Message-ID: <9b2db90b0810240032o4439b48dn47b67ba708f03e77@mail.gmail.com>
References: <9b2db90b0810200735g61cad43dr538c3afc495398ec@mail.gmail.com>
	<15F501D1A78BD343BE8F4D8DB854566B3563A208@hkemmail01.nvidia.com>
	<9b2db90b0810212143k18f336dawd20c76bd1822008b@mail.gmail.com>
	<s5hy70hyx2j.wl%tiwai@suse.de>
	<9b2db90b0810221009v36039a7eu4564c15d79433823@mail.gmail.com>
	<s5h7i7z8l2a.wl%tiwai@suse.de>
	<9b2db90b0810231134t6e3e10h99df8b3bb183741f@mail.gmail.com>
	<s5h7i7z3smz.wl%tiwai@suse.de>
	<9b2db90b0810231308r51a4ee22s103f78cd5782d440@mail.gmail.com>
	<s5htzb2e9lr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.232])
	by alsa0.perex.cz (Postfix) with ESMTP id E8F5D10385F
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 09:33:01 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id c38so90769wra.24
	for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2008 00:32:43 -0700 (PDT)
In-Reply-To: <s5htzb2e9lr.wl%tiwai@suse.de>
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

On Fri, Oct 24, 2008 at 9:27 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 23 Oct 2008 22:08:15 +0200,
> Nir Tzachar wrote:
>>
>> On Thu, Oct 23, 2008 at 11:31 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Thu, 23 Oct 2008 20:34:30 +0200,
>> > Nir Tzachar wrote:
>> >>
>> >> On Thu, Oct 23, 2008 at 10:04 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> >> > At Wed, 22 Oct 2008 19:09:41 +0200,
>> >> > Nir Tzachar wrote:
>> >> >>
>> >> >> On Wed, Oct 22, 2008 at 8:15 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> >> >> > At Wed, 22 Oct 2008 06:43:06 +0200,
>> >> >> > Nir Tzachar wrote:
>> >> >> >>
>> >> >> >> On Wed, Oct 22, 2008 at 4:42 AM, Wei Ni <wni@nvidia.com> wrote:
>> >> >> >> > Hi, Takshi
>> >> >> >> > We have no official plan to support this nforce 630i HDMI audio in linux
>> >> >> >> > now,
>> >> >> >> > and we didn't do any test on it yet. So we can't provide the official
>> >> >> >> > patch for this addition.
>> >> >> >> >
>> >> >> >> > I think if someone interest in it and do some test, he can generate
>> >> >> >> > patch and submit it.
>> >> >> >>
>> >> >> >> As I am interested, and willing o do the tests, I would be happy to
>> >> >> >> know which tests are needed.
>> >> >> >
>> >> >> > If you can play both audio streams and non-audio streams over the device
>> >> >> > by some applications, it's basically confirmed to work :)
>> >> >>
>> >> >> What do you mean by non-audio stream?
>> >> >
>> >> > The passthrough of AC3 stream or so.
>> >> >
>> >> >> Can you give specific commands
>> >> >> which should work?
>> >> >
>> >> > I usually test using ac3dec program included in alsa-tools.
>> >>
>> >> Tried  ac3decode, and got a perfect sound out. I am using the
>> >> following asound.conf (if it is relevant):
>> >
>> > Well, I guess this won't be a non-audio mode.
>> > Try to get the latest alsa-tools git tree.  I changed ac3dec and
>> > now it has -H option.  Specify this together with -C,
>> >
>> >        % ac3dec -C -H foo.ac3
>> >
>> > This will be the AC3 passthru testing.

This is the only one that works:

./ac3dec -R --hdmi /tmp/ac3_the_other_side_48khz.ac3
5.1 Mode 48.0 KHz 640 kbps Complete Main Audio Service
Using PCM device 'plug:hdmi:{AES0 0x0 AES1 0x82 AES2 0x0 AES3 0x2}'

-P and -C give me a strange mewling..

BTW, -H does not work, only --hdmi.


>>
>> http://git.alsa-project.org/http/alsa-tools.git
>> cd alsa-tools
>> make
>>
>> results with a ac3decode without an H option.
>> HEAD: 8a3b9b29010669c085f1821ebc6b6a2672d8d93a
>> which is date to 9/9
>
> Oops, I seem to have forgotten to push.
> Pushed out now.

Cheers,
Nir.
>
> Takashi
>
