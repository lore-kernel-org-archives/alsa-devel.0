From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ALSA: ASoC: davinci-mcasp: clean ip
	davinci_hw_common_param()
Date: Mon, 11 Mar 2013 09:49:27 +0100
Message-ID: <513D9A97.7030901@gmail.com>
References: <1362748778-11076-1-git-send-email-zonque@gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433ED402CB@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f54.google.com (mail-bk0-f54.google.com
 [209.85.214.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EA8326030A
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2013 09:49:30 +0100 (CET)
Received: by mail-bk0-f54.google.com with SMTP id w5so1547803bku.41
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2013 01:49:29 -0700 (PDT)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ED402CB@DBDE01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Michal Bachraty <michal.bachraty@streamunlimited.com>
List-Id: alsa-devel@alsa-project.org

On 11.03.2013 08:09, Bedia, Vaibhav wrote:
> On Fri, Mar 08, 2013 at 18:49:38, Daniel Mack wrote:
>> As pointed of by Vaibhav, commit 2952b27e2 ("ASoC: davinci-mcasp:
>> Add support for multichannel playback") duplicated the logic of
>> counting the active serializers. That can be avoided by shifting
>> the code around a bit.
>>
>> Also, drop two unused defines introduced by the same commit.
>>
> 
> s/clean ip/clean up/ in the $subject.
>
> Other than that, this looks fine to me.
> 
> Acked-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
>

Thanks! Mark - you want me to resend with the fixed subject line or can
you do it when commiting?


Daniel
