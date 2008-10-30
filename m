From: "Bjoern Olausson" <lkmlist@gmail.com>
Subject: Re: Backported sbxfi driver, possible fix
Date: Thu, 30 Oct 2008 12:05:12 +0100
Message-ID: <5501535d0810300405y3e7decdey1ef8f857d2d04c30@mail.gmail.com>
References: <4900A4FA.7020300@jasonline.co.uk> <s5h7i7v22cl.wl%tiwai@suse.de>
	<ge3irb$knf$1@ger.gmane.org> <49055255.8030102@gmail.com>
	<s5h63ne1rh8.wl%tiwai@suse.de>
	<5501535d0810271710y246926f2xdd8a3f31719c6af3@mail.gmail.com>
	<s5h4p2x6vk2.wl%tiwai@suse.de>
	<5501535d0810280648l7d83505bp3f980bc75da9201c@mail.gmail.com>
	<s5h7i7sdd09.wl%tiwai@suse.de>
	<5501535d0810300346m240fb9a2u206e90e6bb4c6b07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.241])
	by alsa0.perex.cz (Postfix) with ESMTP id C5E5C2434A
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 12:05:13 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so496981rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 04:05:12 -0700 (PDT)
In-Reply-To: <5501535d0810300346m240fb9a2u206e90e6bb4c6b07@mail.gmail.com>
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

On Thu, Oct 30, 2008 at 11:46, Bjoern Olausson <lkmlist@gmail.com> wrote:
> On Tue, Oct 28, 2008 at 15:12, Takashi Iwai <tiwai@suse.de> wrote:
>
>
> Now the bad:
>
> Xine does not work... crackles horrible on all sample rates when run from cmd:
> xine 0_16_m_11025.wav
>
> access: MMAP_INTERLEAVED
> format: S16_LE
> subformat: STD
> channels: 2
> rate: 48000 (48000/1)
> period_size: 2048
> buffer_size: 16384
>
> kind regards
> Bjoern
>

mmh, I recompiled xine-lib without mmap support but I still get
access: MMAP_INTERLEAVED

could mmap be a problem?

kind regards
Bjoern
