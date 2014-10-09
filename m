From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: seq module loading issue
Date: Thu, 09 Oct 2014 09:29:10 +0200
Message-ID: <54363946.4010000@ladisch.de>
References: <CAOf41NnCESt3PEGhp3yKgZhScG1H0+qrhz8h3+vjBUfGzfhsyA@mail.gmail.com>
 <s5hd2a1kalk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 2C0EB26053B
 for <alsa-devel@alsa-project.org>; Thu,  9 Oct 2014 09:29:11 +0200 (CEST)
In-Reply-To: <s5hd2a1kalk.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Adam Goode <agoode@chromium.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Adam Goode wrote:
>> 3. Do away with deferred module loading in seq. This is pretty invasive and
>> would increase the number of modules loaded, but would result in a lot of
>> deleted code in the kernel and a clean fix.

I've always wanted to do this (but this was very low priority while this
bug was not known).  The original purpose of the separate seq devices
was to save memory for people who want to only play MP3 files, but this
justification became meaningless long ago for desktop computers, and
embedded systems that care about memory could just disable the
sequencer.

>> Number 3 is my preferred solution, but I wanted to see if these sorts of
>> patches would be acceptable, since it is invasive and would result in more
>> modules loaded.
>
> I don't like that option, it's too risky at this stage.

"This stage" = "for 3.18"?

> If it were a simple cleanup, I'm fine with it.  But this leads to
> a major behavior change, which has a high risk of incompatibility.

But there would be no changed behaviour as far as the API is concerned
(except for this particular issue, which is a bug).


Regards,
Clemens
