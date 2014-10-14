From: Andrej Falout <andrej@falout.org>
Subject: Re: Direct Stream Digital (DSD/DST,
	One Bit Audio) HDMI pass-trough
Date: Tue, 14 Oct 2014 13:49:31 +1300
Message-ID: <CAGzU1+G8rpLokMRbcG4o+SaDB2j79Gx83e6j+3JiMxS3nwVhFQ@mail.gmail.com>
References: <CAGzU1+H-vof2_1UqDTr2pDrnLMrbk0ZHgaAxeM2CaW9=tcPXwQ@mail.gmail.com>
 <543C58AC.9000701@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f46.google.com (mail-la0-f46.google.com
 [209.85.215.46])
 by alsa0.perex.cz (Postfix) with ESMTP id A614D2604FA
 for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2014 02:49:32 +0200 (CEST)
Received: by mail-la0-f46.google.com with SMTP id gi9so7603051lab.19
 for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2014 17:49:32 -0700 (PDT)
In-Reply-To: <543C58AC.9000701@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 14, 2014 at 11:56 AM, Pierre-Louis Bossart <
pierre-louis.bossart@linux.intel.com> wrote:

> On 10/11/14, 1:33 AM, Andrej Falout wrote:
>
>> Hello,
>> <...snip...>
>>     5. Note that as far as I know, no proprietary drivers on Windows
>>     (ATI/AMD, Nvidia, Intel) support this; It will be the first time a
>> device
>>     that is not a SACD player outputs DSD over HDMI, on any OS. I am
>> assuming
>>     that this has nothing to do with hardware limitations of the HDMI
>> chips
>>     used for video outputs (I could not find any reference for such
>> assumption
>>     in any HDMI chips I examined specs for). Therefore, I assume that
>>     implementing this has no hardware prerequisites.
>>
>
> HDMI controllers typically don't support DSD in the PC space. It'd be
> easier to convert to high-res PCM (HBR).
>
>
Hello Pierre-Louis,

Thank you for your comment.

What are you basing your assessment that "HDMI controllers typically don't
support DSD in the PC space"? I looked, but could not find any evidence for
this.

Certainly, DSD is not a part of HDMI hardware implementation (such as for
example, CEC). From all info I have, DSD is simply multiplexed into HDMI
data stream, just as DST-HD or AC3 is.

The goal here is to have a native DSD transport, so conversion to PCM is
not an option.

Thanks,
Andrej Falout
