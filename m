From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH] ALSA: intel8x0: Drop superfluous VM checks
Date: Tue, 5 Apr 2016 15:16:40 -0700
Message-ID: <CALCETrWJzLofCieFvjhMKkfcZUVUxqcEbVb-igacMyYBQevB7Q@mail.gmail.com>
References: <1459867994-22143-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
 [209.85.218.45])
 by alsa0.perex.cz (Postfix) with ESMTP id DE0F3265041
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 00:17:01 +0200 (CEST)
Received: by mail-oi0-f45.google.com with SMTP id y204so35377817oie.3
 for <alsa-devel@alsa-project.org>; Tue, 05 Apr 2016 15:17:01 -0700 (PDT)
In-Reply-To: <1459867994-22143-1-git-send-email-tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Konstantin Ozerkov <kozerkov@parallels.com>, "Luis R . Rodriguez" <mcgrof@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 5, 2016 at 7:53 AM, Takashi Iwai <tiwai@suse.de> wrote:
> intel8x0 driver has the inside_vm check for skipping a buggy hardware
> workaround in the PCM pointer callback in the commit [228cf79376f1:
> ALSA: intel8x0: Improve performance in virtual environment].  This was
> originally applied to all devices on known VMs, but the code was
> switched to use the PCI  ID matching for applying to only known
> devices (KVM and Parallels), in order to avoid applying wrongly to
> VT-d and other such cases, in the commit [7fb4f392bd27: ALSA:
> intel8x0: improve virtual environment detection].
>

[...]

Thanks!
