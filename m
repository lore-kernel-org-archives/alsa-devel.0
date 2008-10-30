From: "Bjoern Olausson" <lkmlist@gmail.com>
Subject: Re: Backported sbxfi driver, possible fix
Date: Thu, 30 Oct 2008 13:25:30 +0100
Message-ID: <5501535d0810300525i61d0fa7cm574dd305bf42e0ec@mail.gmail.com>
References: <4900A4FA.7020300@jasonline.co.uk> <49055255.8030102@gmail.com>
	<s5h63ne1rh8.wl%tiwai@suse.de>
	<5501535d0810271710y246926f2xdd8a3f31719c6af3@mail.gmail.com>
	<s5h4p2x6vk2.wl%tiwai@suse.de>
	<5501535d0810280648l7d83505bp3f980bc75da9201c@mail.gmail.com>
	<s5h7i7sdd09.wl%tiwai@suse.de>
	<5501535d0810300346m240fb9a2u206e90e6bb4c6b07@mail.gmail.com>
	<5501535d0810300405y3e7decdey1ef8f857d2d04c30@mail.gmail.com>
	<s5hd4hi1guk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.228])
	by alsa0.perex.cz (Postfix) with ESMTP id A34F3243B8
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 13:25:31 +0100 (CET)
Received: by rv-out-0506.google.com with SMTP id g9so4013402rvb.7
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 05:25:30 -0700 (PDT)
In-Reply-To: <s5hd4hi1guk.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 30, 2008 at 12:07, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 30 Oct 2008 12:05:12 +0100,
> Bjoern Olausson wrote:
>>
>> On Thu, Oct 30, 2008 at 11:46, Bjoern Olausson <lkmlist@gmail.com> wrote:
>> > On Tue, Oct 28, 2008 at 15:12, Takashi Iwai <tiwai@suse.de> wrote:
>> >
>> >
>> > Now the bad:
>> >
>> > Xine does not work... crackles horrible on all sample rates when run from cmd:
>> > xine 0_16_m_11025.wav
>> >
>> > access: MMAP_INTERLEAVED
>> > format: S16_LE
>> > subformat: STD
>> > channels: 2
>> > rate: 48000 (48000/1)
>> > period_size: 2048
>> > buffer_size: 16384
>> >
>> > kind regards
>> > Bjoern
>> >
>>
>> mmh, I recompiled xine-lib without mmap support but I still get
>> access: MMAP_INTERLEAVED
>
> Maybe it's accessed via alsa-plugin.  What about let xine using
> "hw" PCM device instead of "default"?  Then xine would play at 48kHz
> natively without conversions in alsa-lib.
>

mmh weird... xine works...
Couldn't reproduce my previous report... thought I changed nothing...
Please ignore the xine crackeling... seems not reproducable (If I can
reproduce it, I'll let you know).

Bjoern
