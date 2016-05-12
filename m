From: Trent Reed <treed0803@gmail.com>
Subject: Re: Errors iterating over PCM stream hints and opening
	based on NAME/IOID
Date: Wed, 11 May 2016 22:10:36 -0700
Message-ID: <CAL6pMWqSO9gOQ1voJ9i_LKoq8BVWwBd4RdKQRxVingvfvQsg2w@mail.gmail.com>
References: <CAL6pMWrVwYd7nw46006LeRs=qyBAgeZYTV2K_0pLoMtZYfcfsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f52.google.com (mail-oi0-f52.google.com
 [209.85.218.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B893265068
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2016 07:10:37 +0200 (CEST)
Received: by mail-oi0-f52.google.com with SMTP id v145so102554539oie.0
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2016 22:10:37 -0700 (PDT)
In-Reply-To: <CAL6pMWrVwYd7nw46006LeRs=qyBAgeZYTV2K_0pLoMtZYfcfsQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hey All,

I'm still having trouble understanding this, is anyone able to help me?

Thanks,
- Trent Reed

On Fri, May 6, 2016 at 8:19 PM, Trent Reed <treed0803@gmail.com> wrote:
> Hey All,
>
> (Tried to send an email earlier, it didn't seem to send?)
>
> I'm trying to understand ALSA, having a little trouble with some
> errors that I can't ration over.
> Gist Repro: https://gist.github.com/TReed0803/353ce27d37bc1ebe965854ea88c8b97b
>
> Whenever I run the above simple code (iterate over PCM stream hints,
> open for Playback/Capture depending on IOID; output also provided at
> link above) I notice that I sometimes hit errors. I'm having trouble
> understanding these errors, because as I understand I'm using the ALSA
> library correctly. For example, dmix is telling me that it "Only
> supports playback streams", well then, why does the hint IOID return
> that it supports capture as well? (same for dsnoop). More confusing
> are the "ALSA lib pcm_route.c:867:(find_matching_chmap) Found no
> matching channel map" errors.
>
> Can someone help me understand these issues, and perhaps what I'm
> doing wrong here? Would this point to something wrong with an
> installed package which perhaps configures these hints incorrectly?
> (Assuming that is probably the case, but I'd like to know for sure).
> I'm on a fairly new install of Ubuntu 16.04 LTS.
>
> Thanks,
> - Trent Reed
