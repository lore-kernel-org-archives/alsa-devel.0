From: Carlo Caione <carlo@caione.org>
Subject: Re: DMA buffer alignment
Date: Fri, 5 Dec 2014 02:04:35 +0100
Message-ID: <CAOQ7t2ZNARpAyfr_q9qjsbvbxQU2-AFgQC6aY=Tuurm3dhWPUA@mail.gmail.com>
References: <CAOQ7t2b5Rr6OjpQQ8uvwQ+7O2RL=tTKyjWG1HSJuOc3X4-NDag@mail.gmail.com>
 <548089E3.4060105@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f172.google.com (mail-vc0-f172.google.com
 [209.85.220.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 48ADA260484
 for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2014 02:04:36 +0100 (CET)
Received: by mail-vc0-f172.google.com with SMTP id hq11so8485199vcb.31
 for <alsa-devel@alsa-project.org>; Thu, 04 Dec 2014 17:04:35 -0800 (PST)
In-Reply-To: <548089E3.4060105@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 4, 2014 at 5:20 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Carlo Caione wrote:
>> Several user-space programs (like aplay) work well with my hw, since
>> the buffer sent from the user-space is always (padded) of period-size
>> bytes, that is aligned to my 64 bytes boundary. Others (like
>> speaker-test) are not working because sometimes they snd_pcm_writei()
>> a buffer that is not multiple of 64 bytes.
>
> When a program writes two chunks of 32 bytes each, the final contents of
> the memory are the same.  So what exactly is the problem?

Hi Clemens,
let's say that our application sends uning snd_pcm_writei() a buffer
that is exactly 64 bytes and that our hwoff (appl_ofs) is pointing to
a memory location 0 in the DMA area.
When this buffer is taken from the SoC sound driver, the .copy
callback writes this buffer as follow: 32 bytes (left channel) to
memory locations from *hwoff to *hwoff+31, and 32 bytes (right
channel) for *hwoff+32 to *hwoff+63.
Problem is when my buffer is not multiple of 64 bytes, for example if
the buffer size is < 64. If I receive a buffer of lenght 32 byte than
my DMA memory is filled as follows: 16 bytes from *hwoff to *hwoff+15
and 16 bytes from *hwoff+32 to *hwoff+47, leaving 32 bytes in the
block not initialized. My hardware is always expecting to read a block
of data (64 byte) for *hwoff to *hwoff+63 and it actually does,
reading rubbish from the memory locations not initialized.
Even worst my hw requires that the hw pointer is always aligned to 64
bytes and now my new hw pointer is at *hwoff+32 that is not aligned on
the boundary.
In some way I should always guarantee that the size of the buffer
passed to my .copy callback is multiple of 64 bytes.

I hope this clarifies a bit,

-- 
Carlo Caione
