From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: what is the difference
 between	SNDRV_PCM_IOCTL_WRITEN_FRAMES and SNDRV_PCM_IOCTL_WRITEI_FRAMES
Date: Tue, 21 May 2013 10:01:01 +0200
Message-ID: <519B29BD.1030706@ladisch.de>
References: <6B947C8AC4195040A8C6876A496C644A0852101C@BJ-MAIL-04.vimicro.com>
 <519A0BD7.3050409@ladisch.de>
 <6B947C8AC4195040A8C6876A496C644A0858A774@BJ-MAIL-04.vimicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 50B09261716
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2013 10:01:38 +0200 (CEST)
In-Reply-To: <6B947C8AC4195040A8C6876A496C644A0858A774@BJ-MAIL-04.vimicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zhang wei <zhangwei@vimicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Zhang wei wrote:
>> Multiple buffers, LLL... and RRR...
>
> But how long the data of LLL...and RRR... ?

That is the last parameter of snd_pcm_writen().


Regards,
Clemens
