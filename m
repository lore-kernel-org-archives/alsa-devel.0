From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Direct write (using mmap_bigin and commit)
Date: Tue, 16 Nov 2010 08:10:53 +0100
Message-ID: <4CE22E7D.7010808@canonical.com>
References: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE339@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id D6A4E24439
	for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2010 08:10:59 +0100 (CET)
In-Reply-To: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE339@EXGMBX01.sasken.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Irfan Shaikh <irfan.shaikh@sasken.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 2010-11-15 13:24, Irfan Shaikh wrote:
>                          err = snd_pcm_mmap_begin(handle,&my_areas,&offset,&frames);
>                          mybuffer=(char *)malloc(frames*2);
>                          result = fread (mybuffer,1,(frames*2),pFile);
>                          my_areas.addr=mybuffer;           // IS THIS CORRECT ? WILL THIS WORK ? How can i write my audio file data here in areas?
>                          commitres = snd_pcm_mmap_commit(handle, offset, frames);

No, fread should write directly into the buffer given by 
snd_pcm_mmap_begin, you don't need "mybuffer" at all.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
