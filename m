From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: issue with TWL4030
Date: Mon, 12 Jul 2010 23:26:32 +0300
Message-ID: <AANLkTikjSK3tefAqDAH2i2dxe_n91Z1D5mENqd86Woon@mail.gmail.com>
References: <AANLkTilwdeNLChInBSaFIpVTLDONLXIIHVpLk3Aibk0v@mail.gmail.com>
	<1278366040.3258.238.camel@odin>
	<AANLkTilazb9awx-ncJF31JBx4O2wf2Fimzl9EWI9W7YT@mail.gmail.com>
	<201007121312.48518.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 46D9E245A3
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Jul 2010 22:26:34 +0200 (CEST)
Received: by gxk26 with SMTP id 26so2964419gxk.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Jul 2010 13:26:33 -0700 (PDT)
In-Reply-To: <201007121312.48518.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

hello,

On Mon, Jul 12, 2010 at 1:12 PM, Peter Ujfalusi
<peter.ujfalusi@nokia.com> wrote:
> On Tuesday 06 July 2010 01:51:20 ext Grazvydas Ignotas wrote:
>> On Tue, Jul 6, 2010 at 12:13 AM, =A0<peter.ujfalusi@nokia.com> wrote:
>> > What I can think of is:
>> > If only one (the master) stream has been opened, and the stream is not
>> > running (the pcm_trigger has not been called yet), than we could allow
>> > reconfiguration of the codec. Might work OK, but it might cause some
>> > problems under different scenario.
>>
>> This sounds good to me, I wonder what that different scenario could
>> be.
>
> It's hard to say what scenario, but if we start to fix application bugs in
> driver level, than surely it will not going to be an easy task.

Just to clarify, from OSS point of view the app is correct (and rather
typical), it first sets sample format, then rate and channel count.
There is no way to set all of these at once using OSS API from what I
understand.

>> Is it worth trying implementing that (i.e. would such patch be
>> even considered)?
>
> As of it now, I'm not planning to add workaround to this, since I can not=
 really
> test if it is working correctly.

If you can build a kernel with OSS emulation enabled it's trivial to
test, just run 'mplayer -ao oss' or build the test I sent before (just
include linux/souncard.h, no libraries required).

> Also I just came back from holiday, and my mailbox is quite full, so do n=
ot
> expect that I can even take a look at this in the near future.
>
> Having said that.. since I do care about the twl4030 codec driver (and it=
's
> users), I will try to allocate time to fix it for you.

Thanks!

>> On Tue, Jul 6, 2010 at 12:40 AM, Liam Girdwood <lrg@slimlogic.co.uk> wro=
te:
>> > Please port your app to ALSA, it's really the easiest option (look at
>> > aplay.c for programming sequence).
>>
>> The problem is not new apps, but legacy ones. Pandora is spiritual
>> successor of Gamepark/GPH devices, which only had OSS drivers, so we
>> have many apps/games outputing through OSS, some of them without
>> source available. We will have to provide userspace OSS emulation at
>> least, and in-kernel OSS emulation is attractive because of
>> performance reasons.
>
> I would advice to use the userspace emulation for now. There might be ker=
nel
> level fix for this, but it will take time.
>
> --
> P=E9ter
>
