From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: seq module loading issue
Date: Thu, 09 Oct 2014 11:14:57 +0200
Message-ID: <54365211.5040604@ladisch.de>
References: <CAOf41NnCESt3PEGhp3yKgZhScG1H0+qrhz8h3+vjBUfGzfhsyA@mail.gmail.com>	<s5hd2a1kalk.wl-tiwai@suse.de>
 <54363946.4010000@ladisch.de> <s5ha955k7zr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id D6C2626053E
 for <alsa-devel@alsa-project.org>; Thu,  9 Oct 2014 11:14:59 +0200 (CEST)
In-Reply-To: <s5ha955k7zr.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Adam Goode <agoode@chromium.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
>> Takashi Iwai wrote:
>>> If it were a simple cleanup, I'm fine with it.  But this leads to
>>> a major behavior change, which has a high risk of incompatibility.
>>
>> But there would be no changed behaviour as far as the API is concerned
>> (except for this particular issue, which is a bug).
>
> Currently, the sequencer stuff can be suppressed by simply not loading
> snd-seq core module itself.  Do you mean to drop this feature?

Yes.

> Some distros don't load sequencer modules nowadays as default.

Do you know why?  Any reason except memory?

> So it would result in a clear behavior change on the whole system.

And alsa-lib tries its best to do autoloading to hide the fact that
snd-seq might not have been loaded.  Therefore, it has never been
possible to assume, at any time, that snd-seq is _not_ loaded.

Is the high risk of incompatibility that you mentioned this assumption,
or anything else?


Regards,
Clemens
