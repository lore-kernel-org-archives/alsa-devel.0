From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: what is the difference between
 SNDRV_PCM_FMTBIT_S24_LE and SNDRV_PCM_FMTBIT_S24_3LE
Date: Thu, 11 Apr 2013 11:00:44 +0200
Message-ID: <51667BBC.3070609@ladisch.de>
References: <6B947C8AC4195040A8C6876A496C644A082F1EB2@BJ-MAIL-04.vimicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 62743265072
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 11:00:46 +0200 (CEST)
In-Reply-To: <6B947C8AC4195040A8C6876A496C644A082F1EB2@BJ-MAIL-04.vimicro.com>
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
> SNDRV_PCM_FORMAT_S24_3LE and SNDRV_PCM_FORMAT_S24_LE.
>
> What is the difference between them?

SNDRV_PCM_FORMAT_S24_3LE stores the 24 in three bytes, and is used only
for USB.

SNDRV_PCM_FORMAT_S24_LE stores the 24 bits in the lower bits of a 32-bit
word, and is almost never used.

Most devices that support 24 bits use SNDRV_PCM_FORMAT_S32_LE, which
stores the sample's bits in the upper bits of a 32-bit word.


Regards,
Clemens
