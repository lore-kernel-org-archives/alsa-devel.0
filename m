From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v9 01/12] media: Media device node support
Date: Fri, 18 Feb 2011 22:33:37 +0000
Message-ID: <20110218223337.GC25168@sirena.org.uk>
References: <1297686067-9666-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<1297686067-9666-2-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D861124489
	for <alsa-devel@alsa-project.org>; Fri, 18 Feb 2011 23:33:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1297686067-9666-2-git-send-email-laurent.pinchart@ideasonboard.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: alsa-devel@alsa-project.org, sakari.ailus@maxwell.research.nokia.com, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 14, 2011 at 01:20:56PM +0100, Laurent Pinchart wrote:

> +	  Enable the media controller API used to query media devices internal
> +	  topology and configure it dynamically.
> +
> +	  This API is mostly used by camera interfaces in embedded platforms.

I'd expect this comment is going to bitrot very soon once the framework
goes in.
