From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/17] ASoC: twl6040: Lower the initial
	gains
Date: Mon, 19 Sep 2011 12:40:32 +0100
Message-ID: <20110919114031.GI23727@opensource.wolfsonmicro.com>
References: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
	<1316090379-30760-8-git-send-email-peter.ujfalusi@ti.com>
	<20110919110006.GH23727@opensource.wolfsonmicro.com>
	<2033664.fWQvF2IA53@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6BD5E249E4
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Sep 2011 13:40:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <2033664.fWQvF2IA53@barack>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Dmitry Torokhov <dtor@mail.ru>, linux-kernel@vger.kernel.org, Samuel Ortiz <samuel.ortiz@intel.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 19, 2011 at 02:26:31PM +0300, P=E9ter Ujfalusi wrote:

> Here in twl6040 we also have event handlers to do the ramp up/down on the =

> gains. AFAIK some wm* codec have similar code.

WM8350.
