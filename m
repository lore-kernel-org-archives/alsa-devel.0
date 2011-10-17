From: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Subject: Re: TWL4030 low-latency
Date: Mon, 17 Oct 2011 08:12:11 +0300
Message-ID: <CAPo=G1zpT9wupMnpWBcxEu6iK9vr=EdrkKLMuHkpk7kyBCUMXw@mail.gmail.com>
References: <B4E3E481-AEFC-4E2E-A5FA-A63908D8DE12@ccrma.Stanford.EDU>
	<CAPo=G1yzBxH3FL=Y5yqmR+REVawPV7eAdO5jmrxEJ6RRkndgxg@mail.gmail.com>
	<7C8103E9-A683-4FCA-9E55-9D81A3CA3439@ccrma.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog114.obsmtp.com (na3sys009aog114.obsmtp.com
	[74.125.149.211])
	by alsa0.perex.cz (Postfix) with ESMTP id 93148103819
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Oct 2011 07:12:13 +0200 (CEST)
Received: by mail-qy0-f181.google.com with SMTP id 27so1330207qyk.19
	for <alsa-devel@alsa-project.org>; Sun, 16 Oct 2011 22:12:11 -0700 (PDT)
In-Reply-To: <7C8103E9-A683-4FCA-9E55-9D81A3CA3439@ccrma.Stanford.EDU>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Edgar Berdahl <eberdahl@ccrma.stanford.edu>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Edgar,

On Mon, Oct 17, 2011 at 4:39 AM, Edgar Berdahl
<eberdahl@ccrma.stanford.edu> wrote:
> I'm just starting to get experience with embedded linux systems. I assume=
 that since they have less computational power, interrupt processing could =
use up a larger percentage of that CPU power on average.

It is not just processing power.
We have peripherals attached through slow buses.
Some drivers just disables interrupts while they are communicating
(when they should not).
Embedded environment is quite different from normal desktops, and some
tweaking might be
needed to get optimal results on a given configuration.

>>> 2) Some audio software (e.g. Pure Data, ChucK, etc.) will not connect t=
o the TWL4030 ALSA drivers directly, instead they will only start when jack=
 intermediates between the audio software and the TWL4030 ALSA drivers.
>> No comment.
>> I have used mplayer, pulseaudio, ecasound on Beagle without issues.
> Yes, as far as I know these programs work great! Audio latency is probabl=
y less of a concern for them.

BTW: PA also have 'real time' mode which basically means that it is
using the kernel scheduling
for audio timing. It does not uses the audio interrupts (this should
work fine now).

>> I think I can explain this:
>> McBSP2 has 1280 word long buffer.
> Wow, that is a long buffer! There is no way to reduce the buffer size?

I have some ideas, but it is a long shot.
Basically by design it is not possible, but I might can get around of it by
misusing/configuring the McBSP, and sDMA.
I try to hack something up for kernel 3.3.

> I bet this is where a lot of the latency comes from!

I think you can see rapid period elapsed at the start of the playback
which should
settle down after ~640 samples...


-- =

P=E9ter
