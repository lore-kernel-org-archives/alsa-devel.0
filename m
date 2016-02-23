From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 5/6] control: add a function to add
	an	element of bytes type
Date: Tue, 23 Feb 2016 09:31:42 +0100
Message-ID: <56CC18EE.1070800@ladisch.de>
References: <1456188510-7189-1-git-send-email-o-takashi@sakamocchi.jp>
 <1456188510-7189-6-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 910A3260535
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2016 09:33:40 +0100 (CET)
In-Reply-To: <1456188510-7189-6-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> ALSA Ctl core allows userspace applications to add elements of bytes type,
> while there's no APIs for this purpose in alsa-lib.
>
> This commit adds the missing function.

>  /**
> + * \brief Create and add an user-defined control element of bytes type.
> + * \param[in] ctl CTL handle.
> + * \param[in,out] id ID of the new control element.
> + * \param[in] channels The number of channels which a control element includes.

For this control type, "count" might be a better name.
Or at least say in the description that this is the number of bytes.


Regards,
Clemens
