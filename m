From: Michael Hope <michael.hope-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: prevent compilers from optimising pll
	calculation into __aeabi__uldivmod
Date: Thu, 28 Apr 2011 10:30:24 +1200
Message-ID: <BANLkTin+VhH9bZXub495t1RL+6+SyNndzA@mail.gmail.com>
References: <1303889252-6722-1-git-send-email-bs14@csr.com>
	<s5h8vuwgl7f.wl%tiwai@suse.de>
	<BANLkTi=RuNgN_+26GBrwoHJuz1xSM=YcfQ@mail.gmail.com>
	<s5h1v0ogk6k.wl%tiwai@suse.de>
	<BANLkTimm3wB+EcBZMZzW2SoeJkibisdBWQ@mail.gmail.com>
	<20110427143002.GC31952@opensource.wolfsonmicro.com>
	<BANLkTimOdPO=LJNAM8EqXnMcx3xHPcoOXA@mail.gmail.com>
	<20110427151249.GE31952@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-toolchain-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <20110427151249.GE31952-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-toolchain>,
	<mailto:linaro-toolchain-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-toolchain>
List-Post: <mailto:linaro-toolchain-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-toolchain-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-toolchain>,
	<mailto:linaro-toolchain-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-toolchain-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-toolchain-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, linaro-toolchain-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Zhiwu Song <zhiwu.song-kQvG35nSl+M@public.gmane.org>, Binghua Duan <binghua.duan-kQvG35nSl+M@public.gmane.org>, lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Mark.  The fault exists in FSF GCC 4.5.2 and Linaro GCC
4.5-2011.04.  The fault does not exist in FSF GCC 4.6.0 or Linaro GCC
4.6-2011.04.

-- Michael

On Thu, Apr 28, 2011 at 3:12 AM, Mark Brown
<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> On Wed, Apr 27, 2011 at 11:00:18PM +0800, Barry Song wrote:
>> 2011/4/27 Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
>
>> > If we do have to do something in the callers rather than in do_div() t=
he
>> > annotation seems substantially more taseful than inserting a random asm
>> > into the code.
>
>> I agree. for this patch which will not be applied, people can just get
>> information about how to workaround the gcc issue while they have the
>> same problem. google can find there are other people who failed to
>> compile wm8974 module too. eg.
>> http://irclogs.ubuntu.com/2010/03/30/%23ubuntu-arm.txt
>
>> Andrew Stubbs, Michael Hope in Linaro's toolchain team are working
>> hard on this gcc issue. there have been many update today:
>> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D48783
>
> Is this just some Linaro toolchain that has the issue rather than a
> vanilla GCC release? =A0If so and they fix the compiler bug it doesn't
> seem terribly useful to bodge it in mainline.
>
> _______________________________________________
> linaro-toolchain mailing list
> linaro-toolchain-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
> http://lists.linaro.org/mailman/listinfo/linaro-toolchain
>
