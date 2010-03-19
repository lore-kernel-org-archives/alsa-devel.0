From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Add support for Left
	Justified format
Date: Fri, 19 Mar 2010 11:28:54 +0200
Message-ID: <20100319112854.99c1f692.jhnikula@gmail.com>
References: <1268989879-18303-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DBC21037F5
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 10:27:05 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 4so338194eyg.16
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 02:27:04 -0700 (PDT)
In-Reply-To: <1268989879-18303-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, 19 Mar 2010 11:11:19 +0200
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> Basic support for Left Justified coding for OMAP McBSP.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
>  sound/soc/omap/omap-mcbsp.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
I don't point it out immediately but is the FS polarity correct?
According to WM8772 spec, the left/right justified modes has inverted
FS polarity from I2S.


-- 
Jarkko
