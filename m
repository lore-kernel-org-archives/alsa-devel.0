From: Daniel Mack <zonque@gmail.com>
Subject: Re: USB Audio questions
Date: Tue, 16 Aug 2011 09:30:17 +0200
Message-ID: <CACTFLAOYfJ4eoHfGEaGdjoLijPPzsThrq_kh8So0phoy6fmEGQ@mail.gmail.com>
References: <1313432124-22591-1-git-send-email-lars@metafoo.de>
	<1313432124-22591-2-git-send-email-lars@metafoo.de>
	<4E4A100D.9020302@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C1B6245ED
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Aug 2011 09:30:19 +0200 (CEST)
Received: by gwj17 with SMTP id 17so3680905gwj.38
	for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2011 00:30:18 -0700 (PDT)
In-Reply-To: <4E4A100D.9020302@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 16, 2011 at 8:37 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Pierre-Louis Bossart wrote:
>> - Is there any good reason why the max number of packets per urb default=
s to
>> 8?
>
> Not really. =A0It is an attempt to compromise between interrupt frequency
> and the latency resulting from packet queueing.

Ah, I thought there is a limit of frames per urb that is the same than
subframes per packet on USB. That's not the case then?

>> - Increasing the number of packets/urbs solves my power issue but not the
>> synchronization issue. If I reduce the number of urbs to reduce the
>> interrupt rate, then the accuracy of the hw_pointer is decreased big time
>> and it becomes difficult to synchronize with video. The .pointer routine
>> only keeps track of retired urbs, it seems there's no way to know how ma=
ny
>> samples were played at a given time?
>
> Only the URB completion callback tells us about finished packets.
>
> For playback, we know how many bytes we had submitted, so we could
> derive the current position from the USB frame counter, but for capture,
> we don't know the precise byte count until the HCD has looked at the
> descriptors.

Wouldn't it be possible to not count what we submitted but look at the
playback packets that return from the HCD and move the hwptr there?
That information is presumably closer to the actual hardware position
than the time when we queue.


Daniel
