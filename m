From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ERROR:PCM WRITE ASSRTION FAILED
Date: Wed, 13 Nov 2013 15:02:58 +0100
Message-ID: <52838692.7060705@ladisch.de>
References: <198199338.90738.1384347707434.JavaMail.zimbra@iwavesystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id DCFB1264F47
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 15:03:06 +0100 (CET)
In-Reply-To: <198199338.90738.1384347707434.JavaMail.zimbra@iwavesystems.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ranjith vs <ranjithvs@iwavesystems.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ranjith vs wrote:
> snd_pcm_writei: Assertion `pcm' failed.
>
> what might be the reasons for that

You called snd_pcm_writei with a NULL pcm pointer.

> and is there any solutions.

Remove that bug from your program.


Regards,
Clemens
