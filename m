From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: cs35l32: avoid uninitialized
	variable access
Date: Mon, 25 Jan 2016 17:24:12 +0000
Message-ID: <8F419EEB-6A57-42ED-8BB2-7559E21BE00C@cirrus.com>
References: <1453741678-1988125-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 592DA260535
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2016 18:25:43 +0100 (CET)
In-Reply-To: <1453741678-1988125-1-git-send-email-arnd@arndb.de>
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Austin, Brian" <Brian.Austin@cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


On Jan 25, 2016, at 11:07 AM, Arnd Bergmann <arnd@arndb.de<mailto:arnd@arndb.de>> wrote:

gcc warns about the possibilty of accessing a property read from
devicetree in cs35l32_i2c_probe() when it has not been initialized
because CONFIG_OF is disabled:

sound/soc/codecs/cs35l32.c: In function 'cs35l32_i2c_probe':
sound/soc/codecs/cs35l32.c:278:2: warning: 'val' may be used uninitialized in this function [-Wmaybe-uninitialized]

The code is actually correct because it checks the dev->of_node
variable first and we know this is NULL here, but by adding a
check for IS_ENABLED(CONFIG_OF), we can let the compiler know
as well, and also generate smaller object code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de<mailto:arnd@arndb.de>>
---
sound/soc/codecs/cs35l32.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)
Thanks,

Acked-by: Brian Austin <brian.austin@cirrus.com<mailto:brian.austin@cirrus.com>>
