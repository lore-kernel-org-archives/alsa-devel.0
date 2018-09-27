From: AC30 CTLin0 <ctlin0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8822: new codec driver
Date: Thu, 27 Sep 2018 18:44:45 +0800
Message-ID: <26ac5971-f05b-77e7-c3a5-4fd799fcd64b@nuvoton.com>
References: <20180720110412.19125-1-CTLIN0@nuvoton.com>
 <5BA06283.9000801@nuvoton.com>
 <4c0cc49b-2426-2f5e-028c-f161f2e6553e@nuvoton.com>
 <20180925165613.GO20825@sirena.org.uk> <20180925175247.GA18430@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E8654267889
 for <alsa-devel@alsa-project.org>; Thu, 27 Sep 2018 12:45:10 +0200 (CEST)
In-Reply-To: <20180925175247.GA18430@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

OK, I will resend a new patch.

However, from my last patch file, I can see DT file where is located at
"Documentation/devicetree/bindings/sound/nau8822.txt".

And don't you see any DT file?

On 9/26/2018 1:52 AM, Mark Brown wrote:
> On Tue, Sep 25, 2018 at 09:56:13AM -0700, Mark Brown wrote:
>> On Tue, Sep 25, 2018 at 10:50:19AM +0800, AC30 CTLin0 wrote:
>>> May I learn the status of patch review due to our customer ask us about
>>> upstream status?
>> I don't know, I don't seem to have a copy of this patch in my review
>> queue.  Please resend:
> Found a copy in the list archives, but still no idea where it went in my
> review queue.  My best guess is that it got eaten by spam filtering
> somewhere but I'm not 100% sure.  Sorry about that.  :(  The driver
> looks pretty clean, a few small points:
>
>   - The Mute Switch controls should just be called Switch so that
>     applications know how to handle them.
>   - PGA Boost +20dB should just be "PGA Boost Volume" with the +20dB
>     specified by having it be a SOC_DOUBLE_R_TLV().
>   - The switch statements in hw_params() should have default:
>     cases that return errors so that if an incorrect parameter makes it
>     through we detect it.
>   - There's a DT compatible string but no DT binding file is supplied,
>     should just be a very simple one as there's no parameters.
>
> These are all small, hopefully should be quick to update.


===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
