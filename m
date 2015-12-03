From: Fabio Estevam <festevam@gmail.com>
Subject: Re: mx28: bad unlock balance detected
Date: Thu, 3 Dec 2015 15:45:54 -0200
Message-ID: <CAOMZO5D-PKSZ76uLxEwtK9K6X3j5OnWd-cJZTz3U9p4EkyJ4hA@mail.gmail.com>
References: <CAOMZO5B+j5s69JeeYPnpwn2e_doCA+ARzBSGAcGoJGEJ3=u3BA@mail.gmail.com>
 <20151127121126.GM1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f177.google.com (mail-ig0-f177.google.com
 [209.85.213.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 550B1260525
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2015 18:45:56 +0100 (CET)
Received: by igcph11 with SMTP id ph11so16063852igc.1
 for <alsa-devel@alsa-project.org>; Thu, 03 Dec 2015 09:45:55 -0800 (PST)
In-Reply-To: <20151127121126.GM1929@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 27, 2015 at 10:11 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Nov 26, 2015 at 02:18:04PM -0200, Fabio Estevam wrote:
>> Hi,
>>
>> Running linux-next 20151126 on a mx28evk leads to the following bug:
>>
>> sgtl5000 0-000a: sgtl5000 revision 0x11
>> sgtl5000 0-000a: Using internal LDO instead of VDDD
>>
>> =====================================
>> [ BUG: bad unlock balance detected! ]
>> 4.4.0-rc2-next-20151126-00001-g44eb6b2 #156 Not tainted
>
> This should be fixed in the next -next, Arnd noticed a problem with his
> code.

That's correct. linux-next 20151202 does not show the problem, thanks.
