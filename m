From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v12 6/8] media: i2c: Add TDA1997x HDMI
	receiver driver
Date: Thu, 15 Feb 2018 18:16:57 +0100
Message-ID: <10f08dfb-cc23-a9e3-7439-95955661cb77@xs4all.nl>
References: <1518712767-21928-1-git-send-email-tharvey@gateworks.com>
 <1518712767-21928-7-git-send-email-tharvey@gateworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb2-smtp-cloud7.xs4all.net (lb2-smtp-cloud7.xs4all.net
 [194.109.24.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 96D22267CAE
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 18:16:58 +0100 (CET)
In-Reply-To: <1518712767-21928-7-git-send-email-tharvey@gateworks.com>
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
To: Tim Harvey <tharvey@gateworks.com>, linux-media@vger.kernel.org, alsa-devel@alsa-project.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Hans Verkuil <hansverk@cisco.com>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Philipp Zabel <p.zabel@pengutronix.de>, Steve Longerbeam <slongerbeam@gmail.com>, shawnguo@kernel.org
List-Id: alsa-devel@alsa-project.org

On 15/02/18 17:39, Tim Harvey wrote:
> Add support for the TDA1997x HDMI receivers.
> 
> Cc: Hans Verkuil <hverkuil@xs4all.nl>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v12:
>  - fix coccinelle warnings

Did you post the right version? I still see the owner being set and the
other kbuild warning ('note: in expansion of macro 'v4l_dbg'') is also
still there.

Note that the last one also shows these errors:

drivers/media/i2c/tda1997x.c:387:5-8: WARNING: Unsigned expression compared with zero: val < 0
drivers/media/i2c/tda1997x.c:391:5-8: WARNING: Unsigned expression compared with zero: val < 0
drivers/media/i2c/tda1997x.c:404:5-8: WARNING: Unsigned expression compared with zero: val < 0
drivers/media/i2c/tda1997x.c:408:5-8: WARNING: Unsigned expression compared with zero: val < 0
drivers/media/i2c/tda1997x.c:412:5-8: WARNING: Unsigned expression compared with zero: val < 0
drivers/media/i2c/tda1997x.c:427:6-9: WARNING: Unsigned expression compared with zero: val < 0

This is indeed wrong.

Regards,

	Hans
