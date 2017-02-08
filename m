From: John Rigg <aldev@jrigg.co.uk>
Subject: Re: Cannot combine audio devices with more than
	64	channels
Date: Wed, 8 Feb 2017 16:12:42 +0000
Message-ID: <20170208161242.GA26477@localhost.localdomain>
References: <CAKw=HF0hbhxJ1YGjukjFr72xtEh2FjtH6k0Bh+rFcMwejgwcUg@mail.gmail.com>
 <1cdef19b-a458-7441-2ede-2ba8984ec7cd@ladisch.de>
 <s5hh94khiao.wl-tiwai@suse.de>
 <CAKw=HF1kZ12YOUuBX0MmiyYsPqQ68kafP-cVmWA8FP0dHOAuDw@mail.gmail.com>
 <20170131193159.GA17070@localhost.localdomain>
 <CAKw=HF10J=Sr=qrR6yTB_m3yznDh8boUv_qP1MKN75SXFth40w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vm2962.vps.tagadab.com (vm2962.vps.tagadab.com [95.172.24.202])
 by alsa0.perex.cz (Postfix) with ESMTP id 222AA261740
 for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2017 17:43:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAKw=HF10J=Sr=qrR6yTB_m3yznDh8boUv_qP1MKN75SXFth40w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?J=F6rg_M=FCller?= <joerg.mueller7744@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 08, 2017 at 03:12:37PM +0100, J=F6rg M=FCller wrote:
> John Rigg informed me about the port-max-option of Jack. So I tried
> running the following commands:
> jackd --port-max 1024 -d alsa -C madifx_record_all -P madifx_playback_all
> jackd -p 1024 -d alsa -C madifx_record_all -P madifx_playback_all
> jackd -p1024 -d alsa -C madifx_record_all -P madifx_playback_all
> =

> I also tried ommiting either the option of -C or of -P. But I keep
> getting the same error:
> jackd: ../linux/alsa/JackAlsaDriver.cpp:122: virtual int
> Jack::JackAlsaDriver::Attach(): Assertion `fCaptureChannels < 256'
> failed.
> =

> So does that mean jackd doesn't recognize the parameter -p 1024?

I just tried jackd -p1024 here and there's no error message. I don't
have the hardware to easily test that many ports. I'm using pcm_multi
with three ice1712 cards and that accepts the jackd -p1024 option.
I tried adding jack clients until the default 256 ports was exceeded,
and there's no problem (tried up to 324 ports so far).

In jack2/common/JackGlobals.h it has the following:
#ifndefine PORT_NUM_MAX
#define PORT_NUM_MAX 4096
#endif

It looks like there's a restriction on driver capture and/or
playback channels somewhere, but you might have to grep through
the alsa and jack2 source code to find it.

John
