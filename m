From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: maximum tolerable sampling frequency difference
	for a	driver
Date: Wed, 12 Nov 2008 15:46:08 +0000
Message-ID: <20081112154607.GI8767@sirena.org.uk>
References: <cabda6420811110817u42eafc74wfde36de113c98df1@mail.gmail.com>
	<491AF7D0.40806@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F4931037F0
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 16:46:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <491AF7D0.40806@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: chri <chripell@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 12, 2008 at 04:35:44PM +0100, Clemens Ladisch wrote:

> When an application requests a frequency that is not supported by the
> device, it is the application that must decide whether the actual
> frequency is acceptable.

In theory.  In practice few applications have substantial tolerance for
this and in many situations the cost of dealing with it (such as doing
soft conversion) is worse than a small error.
