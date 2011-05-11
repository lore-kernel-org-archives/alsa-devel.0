From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ASoC: Update cx20442 for TTY API change
Date: Wed, 11 May 2011 11:45:42 +0300
Message-ID: <20110511084540.GM2505@legolas.emea.dhcp.ti.com>
References: <1305099643-10536-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 0766B103813
	for <alsa-devel@alsa-project.org>;
	Wed, 11 May 2011 10:45:48 +0200 (CEST)
Received: by mail-bw0-f54.google.com with SMTP id 12so534219bwz.27
	for <alsa-devel@alsa-project.org>; Wed, 11 May 2011 01:45:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1305099643-10536-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, patches@opensource.wolfsonmicro.com, Felipe Balbi <balbi@ti.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, May 11, 2011 at 09:40:43AM +0200, Mark Brown wrote:
> receive_buf() was recently changed to return the number of bytes
> received but the cx20442 driver wasn't updated to match the new API.
> I don't have any hardware but since we don't actually appears to be
> listening to the data at all just report that we accepted all the data
> that was offered to us.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

FWIW:

Looks good to me

-- 
balbi
