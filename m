From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: ALSA calling pcm_pointer excessively?
Date: Thu, 10 May 2012 13:04:15 -0400
Message-ID: <CA+7tXijRpHp1nP+CWEPc-X_3oDRa9NRYCiXS80AV5DDz-KGjEA@mail.gmail.com>
References: <20120510160601.GC12727@n2100.arm.linux.org.uk>
	<CABb+yY2ivTKqg9q6hB1OLzBHo7zCWO74As048o-jacKkx0wD1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1314C10BACA
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2012 19:04:16 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so1316966wgb.20
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2012 10:04:15 -0700 (PDT)
In-Reply-To: <CABb+yY2ivTKqg9q6hB1OLzBHo7zCWO74As048o-jacKkx0wD1w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, May 10, 2012 at 1:00 PM, Jassi Brar <jassisinghbrar@gmail.com> wrot=
e:
> On Thu, May 10, 2012 at 9:36 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>>
>> The question is - what would cause ALSA to hammer away at the buffer
>> like that - checking it every 16 or 8 DMA bytes transferred? =A0I'm also
>> seeing around 75% system CPU time, which really isn't good.
>>
>> The above was captured while aplay was running, with no apparant audio
>> corruption.
>>
>> Any ideas?
>>
> I believe it's because the pcm's write tries to keep the data in ring
> buffer filled
> upto brim and keeps polling the dma position till it keeps reporting
> some progress.

Seems like it should sleep until avail_min frames are empty?
