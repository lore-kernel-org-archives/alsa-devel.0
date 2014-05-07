From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Too many snd_pcm_mmap_readi calls
Date: Wed, 07 May 2014 14:58:59 +0200
Message-ID: <536A2E13.9070900@ladisch.de>
References: <5369DE58.30208@janhomann.de> <5369F684.7060502@ladisch.de>
 <536A026D.1070104@janhomann.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 68164261B01
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 14:59:01 +0200 (CEST)
In-Reply-To: <536A026D.1070104@janhomann.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jan Homann <jh@janhomann.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jan Homann wrote:
> In my opinion mmap_begin just tells the alsa-lib that someone is about
> to access the buffer.

With mmap_begin, you ask the device how many frames are available in the
buffer (and get a pointer to them).  With mmap_commit, you tell the
device how many frames you actually read.

> I am using mmap because of its good performance.

Using mmap makes sense only when you are accessing the samples in the
buffer directly.  If you just copy the frames into your own buffer,
there is *no* difference whatsoever to snd_pcm_readi.

> Under normal condition with snd_pcm_mmap_readi my program uses about
> 1% of cpu-time where snd_pcm_readi uses about 75%.

It's likely that you do not correctly wait for frames being available
in your real program.

> Do you know a good tutorial about using mmap_readi?

This: use snd_pcm_readi instead.


Regards,
Clemens
