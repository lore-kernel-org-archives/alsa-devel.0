From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ad1836: reset and restore clock control
 mode in suspend/resume entry
Date: Mon, 25 Jan 2010 15:06:36 +0000
Message-ID: <20100125150636.GB27920@rakim.wolfsonmicro.main>
References: <1264408945-25762-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 54DF91038A1
	for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2010 16:06:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1264408945-25762-1-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 25, 2010 at 04:42:25PM +0800, Barry Song wrote:
> tests show frequent suspend/resume(frequent poweroff/on ad1836 internal components)
> maybe make ad1836 clock mode wrong sometimes after wakeup. This patch reset/restore
> ad1836 clock mode while executing PM, then ad1836 can always resume to right clock
> status.
> 
> Signed-off-by: Barry Song <21cnbao@gmail.com>

Applied, thanks.
