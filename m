From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v2 2.6.38] ASoC: WM8994: Ensure late enable
 events are processed for the ADCs
Date: Tue, 01 Mar 2011 14:39:21 +0000
Message-ID: <1298990361.3345.17.camel@odin>
References: <1298980030-6831-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 45A21103923
	for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2011 15:39:25 +0100 (CET)
Received: by mail-ww0-f51.google.com with SMTP id 26so5092082wwf.20
	for <alsa-devel@alsa-project.org>; Tue, 01 Mar 2011 06:39:25 -0800 (PST)
In-Reply-To: <1298980030-6831-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-03-01 at 11:47 +0000, Dimitris Papastamos wrote:
> Ensure that the ADCs are provided with a clock as the previous patch
> "ASoC: WM8994: Improve playback robustness" did not handle this case
> properly.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8994.c |   26 +++++++++++++++++++++++---
>  1 files changed, 23 insertions(+), 3 deletions(-)
> 
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
