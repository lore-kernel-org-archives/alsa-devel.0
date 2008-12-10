From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Ask a question about WM8976
Date: Wed, 10 Dec 2008 11:40:42 +0000
Message-ID: <20081210114037.GE31542@sirena.org.uk>
References: <275270.49497.qm@web15707.mail.cnb.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A5FE424441
	for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2008 12:40:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <275270.49497.qm@web15707.mail.cnb.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: peter meng <mengsanshui@yahoo.com.cn>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 10, 2008 at 02:42:58PM +0800, peter meng wrote:

> 1. Is this mean all widget in wm8976  does not have power management function ? 

Yes.

> 2. If wm8976 does not add widget then the process of 'set up audio path map ' will fails , is this correct ? 

It shouldn't, the driver just turns everything on all the time.  This
will consume more power than is required but other than that should
function fine.
