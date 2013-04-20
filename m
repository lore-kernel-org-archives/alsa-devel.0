From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: DAPM widget power off
Date: Sat, 20 Apr 2013 10:19:15 -0700
Message-ID: <5172CE13.1040208@gmail.com>
References: <CAK=eu+d7DTESE3YGCKfA-BZiT0AGVPUUV8iu0FbM1tiC+MRzZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 by alsa0.perex.cz (Postfix) with ESMTP id BC445265165
 for <alsa-devel@alsa-project.org>; Sat, 20 Apr 2013 19:19:19 +0200 (CEST)
Received: by mail-pd0-f177.google.com with SMTP id u11so2765206pdi.22
 for <alsa-devel@alsa-project.org>; Sat, 20 Apr 2013 10:19:18 -0700 (PDT)
In-Reply-To: <CAK=eu+d7DTESE3YGCKfA-BZiT0AGVPUUV8iu0FbM1tiC+MRzZg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yuvaraj r <yuvaraj.tr@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/18/2013 12:02 AM, yuvaraj r wrote:
> Hi All,
>
> I have two different dais
>
> 1. Hifi Multimedia
>
> 2.  Voice call dai
>
> Before opening voice call dai. I closed Hifi stream. After 5 sec Voice call
>   stream dapm widget got powered off automatically. I am assuming that
> stream close event of Multimedia causing problem.
>
> What will issue in my cause.

The value of snd_soc_card::pmdown_time and 
snd_soc_pcm_runtime::pmdown_time are initialized to 5000 (i.e. 5 secs) 
by default.  That means that after you close a stream, the kernel waits 
5 seconds and then powers everything down.

There's a few reasons why this can happen:

    1. Your DAPM routing doesn't adequately cover the Voice call case.
       Something that is needed for both Voice and Multimedia isn't
       properly associated with the Voice routing... so DAPM shuts
       it down because it's not "in use."

    2. Some of your power-down code is making a poor assumption.  I.e.
       you're making some decisions outside of DAPM about when a
       component should be powered down, and it's the wrong decision.

    3. I've seen a bug in older kernels (e.g. <= 3.1) where the DAPM
       logic will accidentally shut down a capture stream while powering
       down a playback stream.  (E.g. see
       http://review.omapzoom.org/#/c/21405/)

A quick work-around is to set pmdown_time = 0.  However, there will 
still be a race condition... so don't consider it "fixed."  (Though, I'm 
pretty sure I've seen a device ship with this "fix." :-))

-gabriel
