From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 0/5] for-linux/sndif: add explicit back and front
 synchronization
Date: Thu, 12 Apr 2018 12:55:16 -0400
Message-ID: <43348cf5-d2f8-9d7d-0390-2273eef8f67d@oracle.com>
References: <20180412160102.15833-1-oleksandr_andrushchenko@epam.com>
 <d5ede3f5-200e-f1c7-71f4-4ebfb938ca48@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d5ede3f5-200e-f1c7-71f4-4ebfb938ca48@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>, konrad.wilk@oracle.com, tiwai@suse.de
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, jgross@suse.com, "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

On 04/12/2018 12:11 PM, Oleksandr Andrushchenko wrote:
> Hello, Konrad, Takashi!
>
> Could you please review the *Linux Kernel* version of the changes?
> As I said in the cover letter below there is no functional changes
> comparing to the corresponding Xen version, but spaces to tabs.
> Still, formally, I have to drop the R-b tags and request for the new
> review.

Is there any reason why this all can't be done in a single patch?

This is just syncing up with the canonical definition in Xen.

-boris
