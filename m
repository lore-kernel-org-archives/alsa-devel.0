From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: BUG: unable to handle kernel paging request in
	snd_seq_oss_readq_puts
Date: Fri, 17 Nov 2017 21:16:22 +0100
Message-ID: <CACT4Y+ZnDtm0bsz4-Heg7epXHtc_P-Wx+zWXQeRt67HREioDDg@mail.gmail.com>
References: <001a1140b6b825822a055cf02f93@google.com>
 <001a113f890a511649055e335219@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f45.google.com (mail-pg0-f45.google.com [74.125.83.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D096266B67
 for <alsa-devel@alsa-project.org>; Fri, 17 Nov 2017 21:16:44 +0100 (CET)
Received: by mail-pg0-f45.google.com with SMTP id s11so2721221pgc.5
 for <alsa-devel@alsa-project.org>; Fri, 17 Nov 2017 12:16:44 -0800 (PST)
In-Reply-To: <001a113f890a511649055e335219@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: syzbot <bot+31681772ec7a18dde8d3f8caf475f361a89b9514@syzkaller.appspotmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com, Takashi Iwai <tiwai@suse.com>, salyzyn@android.com
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 17, 2017 at 9:10 PM, syzbot
<bot+31681772ec7a18dde8d3f8caf475f361a89b9514@syzkaller.appspotmail.com>
wrote:
> Hello,
>
> syzbot has tested the proposed patch but the reproducer still triggered
> crash:
> no output from test machine

please ignore this, this testing of patch testing
