From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCHv2] ASoC: cs42l51: re-hook of_match_table
	pointer
Date: Wed, 12 Nov 2014 09:17:44 -0600
Message-ID: <alpine.DEB.2.10.1411120916550.23029@heelrod>
References: <1415803244-7010-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0146.outbound.protection.outlook.com [157.56.111.146])
 by alsa0.perex.cz (Postfix) with ESMTP id E4E012656EE
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 16:16:48 +0100 (CET)
In-Reply-To: <1415803244-7010-1-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, alsa-devel@alsa-project.org, Tawfik Bayouk <tawfik@marvell.com>, "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Nadav Haklai <nadavh@marvell.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

> This commit exports the of_device_id array in cs42l51, and uses it as
> .of_match_able in cs42l51-i2c.c. This solution was suggested by Brian
> Austin.
> 
> Fixes: a1253ef6d3fa ("ASoC: cs42l51: split i2c from codec driver")
Acked-by: Brian Austin <brian.austin@cirrus.com>

Thanks
