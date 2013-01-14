From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: HD-audio regression after commit
	34588709af61be1550b4e2bcee5c85d0ac4f34d4
Date: Mon, 14 Jan 2013 12:37:15 +0100
Message-ID: <50F3EDEB.6040807@ladisch.de>
References: <CA+S_cwraM+wofw5Nz_d0ctOget5dY-0nr5pRHCzOJtLX+JM2TA@mail.gmail.com>
 <CAN8ccia1N-eseNR2dET=ghXuyK0E0gXaakehW3VAN8u1UxUQ8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id EC901265236
 for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2013 12:37:18 +0100 (CET)
In-Reply-To: <CAN8ccia1N-eseNR2dET=ghXuyK0E0gXaakehW3VAN8u1UxUQ8Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, diaz.manolo@gmail.com, Miro Hodak <mhodak127@gmail.com>
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:
>> 1. XFCE and Gnome2 audio mixers crash whenever sound is started or stopped.
>> The error message is:
>> simple_none.c:1350: get_enum_item_ops: Assertion `helem' failed.
>
> This is caused by the active access flag of independent headphone control

... which triggers bugs in these mixers.

But as long as mixers with this bug are widespread, it might be a good
idea to avoid ELEM_ACCESS_INACTIVE.


Regards,
Clemens
