From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ASoC: avoid unused variable warning for
	rt5659_acpi_match
Date: Wed, 20 Jan 2016 11:58:51 +0100
Message-ID: <20191003.vNJkcIvuCq@wuerfel>
References: <2238845.aZnycJVYKR@wuerfel> <20160120104555.GY6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by alsa0.perex.cz (Postfix) with ESMTP id 11274260412
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2016 11:59:11 +0100 (CET)
In-Reply-To: <20160120104555.GY6588@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wednesday 20 January 2016 10:45:55 Mark Brown wrote:
> On Wed, Jan 20, 2016 at 11:43:48AM +0100, Arnd Bergmann wrote:
> > The newly added rt5659 codec driver unconditionally defines an
> > ACPI device match table but then uses ACPI_PTR() to remove the
> > only reference to it, so we get a harmless build warning:
> 
> > sound/soc/codecs/rt5659.c:4200:30: warning: 'rt5659_acpi_match' defined but not used [-Wunused-variable]
> >  static struct acpi_device_id rt5659_acpi_match[] = {
> 
> > This removes the ACPI_PTR() to avoid the warning.
> 
> Why is this a better fix than conditionally defining the table?

I'm not overly fond of adding #ifdef if it can be avoided. In this case,
both approaches seemed reasonable (either add an #ifdef or waste a couple
of bytes), and I picked at random. I'll send you the alternative as well,
please apply whichever one you prefer.

	Arnd
