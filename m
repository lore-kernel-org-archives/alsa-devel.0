From: maarten van es <maarten.h.van.es@gmail.com>
Subject: Re: salsa error message setting hwparams
Date: Fri, 24 Apr 2009 20:32:11 +0100
Message-ID: <bca65b460904241232x146c5b2bx7d43f52e7b9bb756@mail.gmail.com>
References: <bca65b460904231231n6eacecc4l783ba028030d4398@mail.gmail.com>
	<49F16899.6090704@ladisch.de>
	<bca65b460904240151h6ad716c2re9bdfb0db67703a0@mail.gmail.com>
	<49F1805D.8070205@ladisch.de>
	<bca65b460904240230g34172bc5r600f3b32f52b7e8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 6BBC31038CC
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Apr 2009 21:32:12 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 22so220338fge.21
	for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2009 12:32:12 -0700 (PDT)
In-Reply-To: <bca65b460904240230g34172bc5r600f3b32f52b7e8a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 24, 2009 at 10:30 AM, maarten van es
<maarten.h.van.es@gmail.com> wrote:
> Hi
>
> Right now I don't have the machine at hand as I'm at work, but I don't
> think the sample format is the problem. Like I said, my program works
> fine with the hdsp on glibc / alsa. On uclibc / salsa I get the error
> setting any hw param, starting with setting the access method to
> rw_interleaved, and including setting the sample rate while I switched
> the card already to the correct rate with amixer.
> Furthermore, if the problem is an unsupported format I wouldn't expect
> the error to be "operation not permitted".
> I'll try that program anyway when I'm back home to see what it tells me.
>
> Thanks
> Maarten
>
> On Fri, Apr 24, 2009 at 10:03 AM, Clemens Ladisch <clemens@ladisch.de> wr=
ote:
>> (please don't top-post)
>>
>> maarten van es wrote:
>>> Thanks, but that's not it. I make sure I set the correct sample rate
>>> with amixer first.
>>
>> And what about the sample format? =A0I looked at the drivers; the two
>> sound cards do not have a common sample format.
>>
>>
>> Best regards,
>> Clemens
>>
>

Thanks, the problem was indeed that I was setting hwparams that are
not supported by the card. I do think salsa lib could return a more
relevant error than "operation not permitted" and I'll see if I can
come up with something for that.
Right now though I am trying to figure out what snd_pcm_writen needs
for its second parameter, void** bufs. I get the error "bad address"
when passing in an array of pointers to a malloc-ed space big enough
to hold a channels' worth of data. Sorry if I am missing obvious
documentation about this, but what should I pass for this parameter?

Regards
Maarten
