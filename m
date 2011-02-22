From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: omap: rx51: Add FM transmitter
 support
Date: Tue, 22 Feb 2011 09:41:00 +0000
Message-ID: <1298367660.3353.11.camel@odin>
References: <1298293042-13801-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B846610386A
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 10:41:03 +0100 (CET)
Received: by wyb28 with SMTP id 28so1935198wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 01:41:03 -0800 (PST)
In-Reply-To: <1298293042-13801-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-02-21 at 14:57 +0200, Jarkko Nikula wrote:
> Si4713 FM transmitter on Nokia RX-51/N900 is connected to same Line out
> signals of TLV320AIC34 than TPA6130 headphone amplifier.
> 
> This patch adds route to transmitter and "FM Transmitter" control to keep
> route active when needed.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---
> - Liam: This goes on top of previous rx51 update (I didn't find those from
>   your tree):

Sorry, just been travelling and have now pushed.

>   http://mailman.alsa-project.org/pipermail/alsa-devel/2011-February/036972.html
> - For those who are keen to try you need following patch in order to be able
>   to activate the FM transmitter:
>   http://marc.info/?l=linux-omap&m=129827572706543&w=2
>   Otherwise there is no any build or runtime dependency to Si4713 driver.
> ---
>  sound/soc/omap/rx51.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)

Applied.

Thanks

Liam
