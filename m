From: Andrew Chant <achant@google.com>
Subject: Re: [PATCH 1/2] ALSA: usb-audio: fix uac control query
	argument
Date: Fri, 23 Mar 2018 00:52:01 -0700
Message-ID: <CANVWZtGoCqD+D7NiGgPbybw7tdDFcJwRX6CkXOtJpC=KUnEtvw@mail.gmail.com>
References: <20180322213956.217933-1-achant@google.com>
 <20180322213956.217933-2-achant@google.com>
 <s5hy3ij9qql.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f193.google.com (mail-yw0-f193.google.com
 [209.85.161.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 64429267282
 for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2018 08:52:03 +0100 (CET)
Received: by mail-yw0-f193.google.com with SMTP id u15so3687282ywg.8
 for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2018 00:52:03 -0700 (PDT)
In-Reply-To: <s5hy3ij9qql.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Benson Leung <bleung@google.com>
List-Id: alsa-devel@alsa-project.org

Applying this now would be great, thank you.

On Mar 23, 2018 12:48 AM, "Takashi Iwai" <tiwai@suse.de> wrote:

On Thu, 22 Mar 2018 22:39:55 +0100,
Andrew Chant wrote:
>
> This patch fixes code readability and should have no functional change.
>
> Correct uac control query functions to account for the 1-based indexing
> of USB Audio Class control identifiers.
>
> The function parameter, u8 control, should be the
> constant defined in audio-v2.h to identify the control to be checked for
> readability or writeability.
>
> This patch fixes all callers that had adjusted, and makes explicit
> the mapping between audio_feature_info[] array index and the associated
> control identifier.
>
> Signed-off-by: Andrew Chant <achant@google.com>

Looks like a nice clean up and fix.
Would you like me applying this now, or better all together later?


thanks,

Takashi
