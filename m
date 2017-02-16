From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8825: automatic BCLK and LRC
 divde in master mode
Date: Thu, 16 Feb 2017 10:08:38 +0800
Message-ID: <58A509A6.1010304@nuvoton.com>
References: <1487051073-2350-1-git-send-email-KCHSU0@nuvoton.com>
 <20170214110908.nhklqtcy5dohhned@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 86B402666EA
 for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2017 03:08:43 +0100 (CET)
In-Reply-To: <20170214110908.nhklqtcy5dohhned@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, "anatol.pomozov@gmail.com" <anatol.pomozov@gmail.com>, AC30 YHChuang <YHCHuang@nuvoton.com>, AC30 WTLi <WTLI@nuvoton.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "benzh@chromium.org" <benzh@chromium.org>, AC30 CTLin0 <CTLIN0@nuvoton.com>, MS40 MHKuo <MHKuo@nuvoton.com>, "yong.zhi@intel.com" <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,
On 2/14/2017 7:09 PM, Mark Brown wrote:
> On Tue, Feb 14, 2017 at 01:44:33PM +0800, John Hsu wrote:
>> Provide the automatic configurable LRC and BCLK divide. The driver
>> will make configurations of LRC and BCLK automatically according to
>> BCLK and FS information in master mode.
>
> This patch *still* does not apply.  Please, try sending to yourself and
> applying with git am before you resend to me.  Check that the patch is
> not being corrupted when you send it (things like space/tab conversion
> for example).

I have resent the patch to myself. And copy the mail content to a new
patch. Then try the command as follows, and it seems work fine.
git am --signoff < ASoC-nau8825-auto-BCLK-and-LRC-divide.patch

Here are the git logs in my site.

commit ce7f61934872c0bc701d93de2db39260b44a8ebd
Author: John Hsu <KCHSU0@nuvoton.com>
Date:   Wed Feb 15 17:13:43 2017 +0800

     ASoC: nau8825: automatic BCLK and LRC divde in master mode

     Provide the automatic configurable LRC and BCLK divide. The driver
     will make configurations of LRC and BCLK automatically according to
     BCLK and FS information in master mode.

     Signed-off-by: John Hsu <KCHSU0@nuvoton.com>

commit 71d7b89701f4e2bee4710bd229e254156006f69b
Merge: 92dfbd1 af4b654 66ead50
Author: Mark Brown <broonie@kernel.org>
Date:   Thu Feb 9 23:48:22 2017 +0000

     Merge remote-tracking branches 'asoc/topic/wm8753' and
'asoc/topic/zte' into asoc-next

commit 92dfbd159676290c359f94ff0e5637eb00d4b170




===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
