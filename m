From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 16/39] firewire-lib: Add some AV/C general
 commands
Date: Fri, 14 Mar 2014 23:18:32 +0100
Message-ID: <53238038.9020900@ladisch.de>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-17-git-send-email-o-takashi@sakamocchi.jp>
 <531CDE06.40604@ladisch.de> <53230DF0.6090105@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id B550F262610
 for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2014 23:19:12 +0100 (CET)
In-Reply-To: <53230DF0.6090105@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> can I request your comments about corresponding between response codes and Linux error codes?
>
> Current my idea is below.
>
> Return codes of CONTROL command:
> if (err != 8) /* length of response is out of specification */
>     err = -EIO;
> else if (buf[0] == 0x08) /* NOT IMPLEMENTED */
>     err = -ENOSYS;
> else if (buf[0] == 0x0a) /* REJECTED */
>     err = -EINVAL;
>
> Return codes of STATUS command:
> if (err != 8)  /* length of response is not our expectation */
>     err = -EIO;
> else if (buf[0] == 0x08) /* NOT IMPLEMENTED */
>     err = -ENOSYS;
> else if (buf[0] == 0x0a) /* REJECTED */
>     err = -EINVAL;
> else if (buf[0] == 0x0b) /* IN TRANSITION */
>     err = -EAGAIN;
>
> Are these better?

Yes, these look like the codes that match best.


Regards,
Clemens
