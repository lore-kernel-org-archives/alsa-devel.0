From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ALSA: hda - Revert DSP detection on legacy
	HD-audio driver
Date: Mon, 31 Dec 2018 10:20:38 -0800
Message-ID: <CAHk-=wiBqzAmf8ZZO84mNF5poNfsynZxGD5y8+ZK5mhrwpeCQQ@mail.gmail.com>
References: <20181231181720.11396-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DF4D267AF9
 for <alsa-devel@alsa-project.org>; Mon, 31 Dec 2018 19:20:56 +0100 (CET)
Received: by mail-lf1-f68.google.com with SMTP id l10so18656285lfh.9
 for <alsa-devel@alsa-project.org>; Mon, 31 Dec 2018 10:20:56 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com.
 [209.85.208.182])
 by smtp.gmail.com with ESMTPSA id y23-v6sm10269892ljk.95.2018.12.31.10.20.54
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Dec 2018 10:20:54 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id l15-v6so24043521lja.9
 for <alsa-devel@alsa-project.org>; Mon, 31 Dec 2018 10:20:54 -0800 (PST)
In-Reply-To: <20181231181720.11396-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Azat Khuzhin <dohardgopro@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 31, 2018 at 10:17 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> This essentially reverts the commits  c337104b1a16 ("ALSA: HD-Audio:..."

I was cc'd, but I'm assuming that you didn't mean for me to apply this
directly, and will be sending a pull request later.

But if you *did* want me to apply this as a patch, holler.

                  Linus
