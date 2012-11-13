From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: Races in alsa-lib with threads
Date: Tue, 13 Nov 2012 02:14:08 -0500
Message-ID: <CA+7tXijc833Bvi-E-L2itnRGF0CNBEY-sahgRhzD_uuws+TQwA@mail.gmail.com>
References: <CA+7tXig7cz8bOuKf3Dqk+iPErY9OKz4hD5L=MM=1vHFUdtPJQQ@mail.gmail.com>
 <s5hbof5ef7s.wl%tiwai@suse.de> <509FD3BE.7090504@perex.cz>
 <loom.20121112T203721-204@post.gmane.org>
 <s5hwqxqvwra.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 809D326030F
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 08:14:09 +0100 (CET)
Received: by mail-vc0-f179.google.com with SMTP id f13so6883745vcb.38
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2012 23:14:08 -0800 (PST)
In-Reply-To: <s5hwqxqvwra.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Rob Krakora <B42341@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 13, 2012 at 1:32 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 12 Nov 2012 19:40:42 +0000 (UTC),
> Rob Krakora wrote:
>> Would you be able to point me the the ALSA documentation that indicates the
>> stipulations on handle usage using multiple threads?  I cannot find it.
>
> Think other way round:
> The fact that it isn't documented means it's not safe to use in that
> way :)


The introduction on the alsa-project home page says, "SMP and
thread-safe design. "  Some people might misunderstand what
thread-safe means.  Maybe some clarification could be added.
"Different streams are SMP and thread-safe (calls for the same stream
must be serialized)."
