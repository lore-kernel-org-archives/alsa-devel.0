From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: "alsactl store" fails to save Echo Gina3G mixer
Date: Tue, 3 Oct 2017 10:53:30 +0900
Message-ID: <5a3cbe62-f0c6-17eb-7e5b-5ece7964546c@sakamocchi.jp>
References: <d8d6d07c-ade6-1ccc-7111-ed367fccf0f9@gmail.com>
 <1fa01cef-7159-b1b2-8ec6-5eab7f2a7e29@sakamocchi.jp>
 <7ef92b65-ef37-1a68-b1d8-e3a747859200@gmail.com>
 <e59f34a8-0999-c552-00e0-3d20a0721d3f@sakamocchi.jp>
 <1709042113040.5915@beth.localdomain>
 <d4b1b2e2-687a-a9fc-4244-9ca54d709f60@gmail.com>
 <4464e5e9-9ce2-3d94-d9ab-3aae6e0b94bd@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id F115F267277
 for <alsa-devel@alsa-project.org>; Tue,  3 Oct 2017 03:53:33 +0200 (CEST)
In-Reply-To: <4464e5e9-9ce2-3d94-d9ab-3aae6e0b94bd@sakamocchi.jp>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "S. Christian Collins" <s.chriscollins@gmail.com>, Mark Hills <mark@xwax.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi S. Christian and Mark,

On Sep 15 2017 14:21, Takashi Sakamoto wrote:
> On Sep 14 2017 22:40, S. Christian Collins wrote:
>> Takashi, is there anything else you would like me to do to help with 
>> this issue? Should it perhaps be filed on the bug tracker so it 
>> doesn't get lost in this list?
> 
> Sorry to be late for reaction, but we're on merge window for v4.14 and I 
> keep my time for unexpected accidents such as this[1]. I'd like to 
> postpone this discussion after closing the window, a few days later.
> 
> [1] 
> http://mailman.alsa-project.org/pipermail/alsa-devel/2017-September/125474.html 

First of all, I apologize for the inconvenience. It's my fault. 
Yesterday a maintainer of this subsystem applies my patch[1] to revert 
the issued commit. It will also be applied to stable/longterm kernels. 
If you use one of the maintained kernels in any distribution such as 
Fedora, you may get solved driver enough later.

However, current echoaudio drivers have an issue in a point of ALSA 
control interface, as I noted to the patch. For this issue, I'm 
preparing for my proposal in Audio miniconference 2017[2]. If the 
'echomixer' program is going to be modified according to our decision, 
I'll request you to test my patches, perhaps. I'm happy to get your 
helps for the testing in future.

Thanks for your report for this issue, and patience.

[1] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-October/126030.html
[2] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-October/126033.html


Takashi Sakamoto
