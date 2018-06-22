From: Harald Schuster <schuster@technikum-wien.at>
Subject: poll blocked after prepare state
Date: Fri, 22 Jun 2018 18:36:12 +0000
Message-ID: <20180622183612.Horde.zlSuz13lBOQlZHX62qPNxF5@webmail.technikum-wien.at>
References: <20180621104224.Horde.WJU_RKtLDLoAGMPfW3FREnA@webmail.technikum-wien.at>
 <20180622132921.Horde.VdiLUhoIz-J3ymTOC0qkzL5@webmail.technikum-wien.at>
 <s5h7emq3oxb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bifrost.technikum-wien.at (bifrost.technikum-wien.at
 [195.245.225.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B9FA266D04
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 20:36:15 +0200 (CEST)
Received: from mail.technikum-wien.at (groupware.technikum-wien.at
 [10.127.0.250])
 by bifrost2.technikum-wien.at (Postfix) with ESMTPS id AEE34428
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 20:36:12 +0200 (CEST)
In-Reply-To: <s5h7emq3oxb.wl-tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Zitat von Takashi Iwai <tiwai@suse.de>:

> On Fri, 22 Jun 2018 15:29:21 +0200,
> Harald Schuster wrote:
>>
>> I found out that an underrun occours and so the pcm_prepare function
>> for pcm_direct is called and then pcm_start_dshare is called. Both
>> functions returns without any error but the playback path is blocked
>> in the snd_pcm_wait_nocheck function. I read that there was an similar
>> problem before in the group but i didn't found any solution. Is this a
>> problem in the driver and how can i go forward to fix it. The codec is
>> a tlv320aic3x-audio. Thanks for your help.
>
> Does this happen with the very latest alsa-lib git version?
> Just to be sure.
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Hi
We are using k4.1.15-6QP+ga2066af.
br Harald
