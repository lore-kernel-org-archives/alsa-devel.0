From: Richard Zhao <linuxzsc@gmail.com>
Subject: Re: How to tell user level hardware not support a
	certain format in a certain sample rate
Date: Sun, 15 Mar 2009 18:38:13 +0800
Message-ID: <4e090d470903150338q74cd3538xe908bc3d7df9a8de@mail.gmail.com>
References: <4e090d470902222302g16a99f5dq77d0d40f6cba855e@mail.gmail.com>
	<4e090d470903020604h27ce2ce8l47f996edc9764ada@mail.gmail.com>
	<49AC0232.1060909@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 502772433D
	for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2009 11:38:14 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id v27so1269030wah.16
	for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2009 03:38:13 -0700 (PDT)
In-Reply-To: <49AC0232.1060909@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 2, 2009 at 11:58 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Richard Zhao wrote:
>> runtime->hw.rates and runtime->hw.formats indicate the rate and
>> formats hardware can support, so the user level plugins can
>> auto-convert the audio data. But hardware may not support a certain
>> combin of sample rate and format,
>
> Did you install your own constraint rules, as described in section
> "Constraints" of "Writing an ALSA Driver"?
>
>
> Best regards,
> Clemens
>

Sure I can add rules. but the rules will be checked as hw_param. If
hw_param failed, does alsalib convert fmt or sample rate
automatically?

For example:
One codec, support:
44.1k : s8 s16 s24 s32
96k:  s24 s32

When user try to play s8/s16 96k audio file, hw_param will fail. I
don't know, how to let alsalib convert s8/s16 to s32 or convert 96k to
44.1k automatically?

Thanks
Richard
