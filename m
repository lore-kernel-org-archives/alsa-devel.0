From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Rawmidi
Date: Sun, 27 Dec 2015 16:57:33 +0900
Message-ID: <567F99ED.4070706@sakamocchi.jp>
References: <CAL_NL1DGv74+62K9A_82osf6ywc9pPVPZhrZd+BsGs7tCnAxqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 06B84261A76
 for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2015 08:57:38 +0100 (CET)
In-Reply-To: <CAL_NL1DGv74+62K9A_82osf6ywc9pPVPZhrZd+BsGs7tCnAxqQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Viksporre <daniel.viksporre@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Dec 27 2015 15:29, Daniel Viksporre wrote:
> I cant compile example programs that use rawmidi.
> 
> When I look on my harddrive, I have many rawmidi.h files, but since
> 2015 they are all 0 bytes. Can that be the reason I cant compile. But
> why is those files 0 bytes from the repository Im using?
> 
> I get the following error messages...
> 
> 
> test.c:(.text+0x507): undefined reference to `snd_rawmidi_open'
> test.c:(.text+0x5d8): undefined reference to `snd_rawmidi_open'
> test.c:(.text+0x75e): undefined reference to `snd_rawmidi_read'
> test.c:(.text+0x846): undefined reference to `snd_rawmidi_write'
> test.c:(.text+0x867): undefined reference to `snd_rawmidi_write'
> test.c:(.text+0x888): undefined reference to `snd_rawmidi_write'
> test.c:(.text+0x894): undefined reference to `snd_rawmidi_drain'
> test.c:(.text+0x8c1): undefined reference to `snd_rawmidi_write'
> test.c:(.text+0x8e2): undefined reference to `snd_rawmidi_write'
> test.c:(.text+0x903): undefined reference to `snd_rawmidi_write'
> test.c:(.text+0x90f): undefined reference to `snd_rawmidi_drain'
> test.c:(.text+0xa71): undefined reference to `snd_rawmidi_read'
> test.c:(.text+0xae0): undefined reference to `snd_rawmidi_write'
> test.c:(.text+0xaec): undefined reference to `snd_rawmidi_drain'
> test.c:(.text+0xb8f): undefined reference to `snd_rawmidi_drain'
> test.c:(.text+0xb9b): undefined reference to `snd_rawmidi_close'
> test.c:(.text+0xbaf): undefined reference to `snd_rawmidi_drain'
> test.c:(.text+0xbbb): undefined reference to `snd_rawmidi_close'

Can you show command lines to compile your 'test.c'?


Regards

Takashi Sakamoto
