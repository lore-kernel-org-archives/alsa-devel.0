From: Andrew Chant <achant@google.com>
Subject: Re: [RFC,
 alsa-utils] RFC: alsamixer: Improve description of playback switches
Date: Mon, 26 Mar 2018 13:41:50 -0700
Message-ID: <CANVWZtF6B_Bnv+tGfUVVkjE8PhBQXSMqTdUBa-n1D+uMeVh4=Q@mail.gmail.com>
References: <20180326051144.16672-1-k.marinushkin@gmail.com>
 <s5ho9jb70ce.wl-tiwai@suse.de>
 <58f2b5d7-35ce-7233-2dbf-d4e1f0b1f617@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f196.google.com (mail-wr0-f196.google.com
 [209.85.128.196])
 by alsa0.perex.cz (Postfix) with ESMTP id DF8FC266FA1
 for <alsa-devel@alsa-project.org>; Mon, 26 Mar 2018 22:42:32 +0200 (CEST)
Received: by mail-wr0-f196.google.com with SMTP id u46so20224542wrc.11
 for <alsa-devel@alsa-project.org>; Mon, 26 Mar 2018 13:42:32 -0700 (PDT)
In-Reply-To: <58f2b5d7-35ce-7233-2dbf-d4e1f0b1f617@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 26, 2018 at 11:32 AM, Kirill Marinushkin
<k.marinushkin@gmail.com> wrote:
> I faced 2 problems:
>
> * the clock source validity was displayed as [O]. I thought it is a zero, which is the opposite from the real state
> * I couldn't find how to turn the processing feature on. The help doesn't say anything about it

A recent patch of mine changed clock source validity from a mixer to a
global control, so it should no longer show up in alsamixer.
