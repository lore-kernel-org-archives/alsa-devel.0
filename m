From: Andy Robinson <ajr55555@gmail.com>
Subject: Re: [PATCH 2/2] ALSA: HDA: Add a new model "asus" for
 Conexant 5066/205xx
Date: Sat, 22 Jan 2011 01:19:11 -0500
Message-ID: <AANLkTi=ACYb1J6enjs0GeOqkPfib1+3XfHuBBaL0FejP@mail.gmail.com>
References: <4D398008.8080707@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B898D243FE
	for <alsa-devel@alsa-project.org>; Sat, 22 Jan 2011 07:19:13 +0100 (CET)
Received: by yxs7 with SMTP id 7so860759yxs.38
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 22:19:12 -0800 (PST)
In-Reply-To: <4D398008.8080707@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks! This also works for the Asus U50F (0x1043 0x1993); however,
the U50F has a SPDIF output, which the model disables. There is an
additional issue with that.. on the U50F, the jack is connected to the
digital output at node 0x12, not the node 0x21 that is currently used
bu the cxt5066 patch.

On Fri, Jan 21, 2011 at 7:46 AM, David Henningsson
<david.henningsson@canonical.com> wrote:
> BugLink: http://bugs.launchpad.net/bugs/701271
>
> This new model, named "asus", is identical to the "hp_laptop" model,
> except for the location of the internal mic, which is at pin 0x1a.
> It is used for Asus K52JU and Lenovo G560.
>
> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
> --
> David Henningsson, Canonical Ltd.
> http://launchpad.net/~diwic
