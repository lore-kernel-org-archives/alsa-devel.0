From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: what is the difference between
 SNDRV_PCM_FMTBIT_S24_LE and SNDRV_PCM_FMTBIT_S24_3LE
Date: Thu, 11 Apr 2013 11:35:57 +0200
Message-ID: <516683FD.4000804@ladisch.de>
References: <6B947C8AC4195040A8C6876A496C644A082F1EB2@BJ-MAIL-04.vimicro.com>
 <51667BBC.3070609@ladisch.de>
 <6B947C8AC4195040A8C6876A496C644A082F1EEE@BJ-MAIL-04.vimicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id A1930266013
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 11:35:59 +0200 (CEST)
In-Reply-To: <6B947C8AC4195040A8C6876A496C644A082F1EEE@BJ-MAIL-04.vimicro.com>
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

(please do not drop the mailing list from replies.)

Zhang wei wrote:
> I do not really understand. For example,an codec is wm8985 ...

The SNDRV_PCM_* symbols specify the format in which samples are
stored in memory.

I do not know how ASoC maps these symbols to on-the-wire formats.

>>Most devices that support 24 bits use SNDRV_PCM_FORMAT_S32_LE, which
>>stores the sample's bits in the upper bits of a 32-bit word.
>
> But how to distinguish the SNDRV_PCM_FORMAT_S24_LE and the REAL
> SNDRV_PCM_FORMAT_S32_LE?

If a 24-bit sample with the value 0x123456 is stored in memory, it looks
like this:
SNDRV_PCM_FORMAT_S24_LE: 56 34 12 00
SNDRV_PCM_FORMAT_S32_LE: 00 56 34 12


Regards,
Clemens
