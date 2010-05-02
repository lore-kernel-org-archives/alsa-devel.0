From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: Reforming S3C I2S towards supporting I2Sv4
Date: Sun, 2 May 2010 17:28:03 +0900
Message-ID: <z2t1b68c6791005020128n5c501797n61ebd15466ac683e@mail.gmail.com>
References: <1268207335-9947-1-git-send-email-jassi.brar@samsung.com>
	<20100310142314.GD6850@sirena.org.uk>
	<20100427025848.GB24020@trinity.fluff.org>
	<q2x1b68c6791004262125o69932e63qd9ddc885b2627dd0@mail.gmail.com>
	<i2w9c9fda241005012138j844af741va32948bb0971b77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5D724244C1
	for <alsa-devel@alsa-project.org>;
	Sun,  2 May 2010 10:28:05 +0200 (CEST)
Received: by vws16 with SMTP id 16so765128vws.38
	for <alsa-devel@alsa-project.org>; Sun, 02 May 2010 01:28:03 -0700 (PDT)
In-Reply-To: <i2w9c9fda241005012138j844af741va32948bb0971b77@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jassi Brar <jassi.brar@samsung.com>, Ben Dooks <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

On Sun, May 2, 2010 at 1:38 PM, Kyungmin Park <kmpark@infradead.org> wrote:
> Do you have a plan to move or create the sound/soc/samsung or others
> for future Samsung SoCs?
I don't have any such plan atm, but I am not against moving sound/soc/s3c24xx
to sound/soc/samsung

> And can you make a document which SoCs use I2S version?
> e.g.,
> s3c24xx use I2Sv3
> s3c64xx use I2Sv3 or 4??
> s5p64xx use I2Sv4
> s5pc1xx use I2Sv5
> and so on
>
> How about to give name samsung-i2cvx for common use instead of cpu name?
>
I think it is better to call drivers by the first soc that is supported
in mainline. Any new soc, that has the controller reused, should be handled
by the same old driver. For example, if we have driver for s5pc100, then
let s5pc110/v210 use the same s5pc100-i2s.c That is, after soc support
in current drivers is sorted out.
