From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add Amesom ASoC machine support.
Date: Tue, 20 Nov 2007 12:43:25 +0000
Message-ID: <20071120124324.GB21414@sirena.org.uk>
References: <1195550746-6892-12-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-13-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-14-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-15-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-16-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-17-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-18-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-19-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-20-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4742D3A2.4020606@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 155D124A17
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 13:43:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4742D3A2.4020606@ru.mvista.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Vladimir A. Barinov" <vbarinov@ru.mvista.com>, Nicola Perrino <nicola.perrino@atlab.it>
Cc: tiwai@suse.de, liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 20, 2007 at 03:31:30PM +0300, Vladimir A. Barinov wrote:

> I suggest to do the same naming changes in the machine part like I 've 
> suggested for tlv32024K codec driver: rename all tlv320 places to 
> tlv320aic2x and "aic2x_"

> Also I suggest to name all static functions in the machine ASoC part to 
> begin from ameson_ and not the codec one.

That all seems sensible.  Nicola, could you look into this please?

Thanks.
