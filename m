From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: Support direct microphone detection
 IRQ
Date: Fri, 18 Feb 2011 08:46:31 +0200
Message-ID: <4D5E15C7.20602@nokia.com>
References: <1298001983-8047-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 39817103810
	for <alsa-devel@alsa-project.org>; Fri, 18 Feb 2011 07:46:36 +0100 (CET)
In-Reply-To: <1298001983-8047-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 02/18/11 06:06, ext Mark Brown wrote:
> Allow direct routing of the WM8958 microphone detection signal to a GPIO
> to be used, saving the need to demux the interrupt.
> =

> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  include/linux/mfd/wm8994/pdata.h |    5 +++
>  sound/soc/codecs/wm8994.c        |   57 +++++++++++++++++++++++---------=
-----
>  2 files changed, 40 insertions(+), 22 deletions(-)

Probably the commit title should contain wm8994 as well.
First I thought that you are implementing soc wide abstraction...

-- =

P=E9ter
