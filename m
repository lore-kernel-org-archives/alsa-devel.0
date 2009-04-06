From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: correct s6000 I2S clock polarity
Date: Mon, 6 Apr 2009 11:23:42 +0100
Message-ID: <20090406102341.GA31607@rakim.wolfsonmicro.main>
References: <49D9D001.7070901@emlix.com>
	<1239011422-23249-1-git-send-email-dg@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1208824402
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Apr 2009 12:23:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1239011422-23249-1-git-send-email-dg@emlix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 06, 2009 at 11:50:22AM +0200, Daniel Gl=F6ckner wrote:
> According to the data sheet data is clocked out on the falling edge
> and latched on the rising edge of the bit clock. While the left sample
> is transmitted the word clock line is low.

> Signed-off-by: Daniel Gl=F6ckner <dg@emlix.com>

Applied, thanks!
