From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/1] ALSA: virtuoso: add de-emphasis control
Date: Thu, 20 Dec 2018 00:09:53 +0100
Message-ID: <0381895c-579e-8403-55e6-bff575957025@ladisch.de>
References: <6b7d5f70-5e5a-59b4-9daf-315937a49639@ladisch.de>
 <5c16909a.1c69fb81.2150c.9583@mx.google.com>
 <bab819ed-38a4-dd8f-5505-663539b80d20@ladisch.de>
 <CAGnHSEmjq1wnb0-5pBkKQYX77fRGw7akdu1z+t8s6ajkyQAofQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 01DAA267A8E
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2018 00:10:20 +0100 (CET)
In-Reply-To: <CAGnHSEmjq1wnb0-5pBkKQYX77fRGw7akdu1z+t8s6ajkyQAofQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tom Yan wrote:
> Considering with my patch this is the only remaining usage of it, do
> you think I should just change it into "PCM1796_DME_DISABLED" and keep
> this manner (so that it is consistent with rolloff_get() /
> PCM1796_FLT_SHARP)?
> Or do you insist that I should use !! anyway?

There is no "PCM1796_DME_DISABLED" symbol.  IMO this is not necessary
for register bits with a boolean meaning.

You could add it if you wanted to, but I do not think that consistency
would be sufficient reason for that.



Regards,
Clemens
