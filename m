From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: snd-ctxfi
Date: Mon, 1 Jun 2009 21:47:02 -0400
Message-ID: <75b66ecd0906011847i7d74d878n8e734fe9e6031e4d@mail.gmail.com>
References: <4A20A683.9010102@gmail.com> <s5hr5y7hy77.wl%tiwai@suse.de>
	<4A215D56.7080601@gmail.com> <s5hmy8sfhfp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id B6D6924442
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 03:47:03 +0200 (CEST)
Received: by ewy23 with SMTP id 23so8561330ewy.32
	for <alsa-devel@alsa-project.org>; Mon, 01 Jun 2009 18:47:02 -0700 (PDT)
In-Reply-To: <s5hmy8sfhfp.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, The Source <thesourcehim@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 1, 2009 at 5:10 AM, Takashi Iwai <tiwai@suse.de> wrote:
> Thanks. =A0So, something wrong in the mmap handling.
> I'll take a look later in this week.

Looks like ct_map_audio_buffer calls ct_vm_map under spinlock;
ct_vm_map calls get_vm_block which calls kzalloc with GFP_KERNEL.

Lee
