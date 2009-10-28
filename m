From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: A question about the soc jack status
Date: Wed, 28 Oct 2009 10:21:41 +0000
Message-ID: <20091028102140.GA23925@sirena.org.uk>
References: <4AE7EFE1.9000407@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1916A103833
	for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2009 11:21:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4AE7EFE1.9000407@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: kyungmin.park@samsung.com, alsa-devel@alsa-project.org, knhoon.baik@samsung.com
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 28, 2009 at 04:16:49PM +0900, Joonyoung Shim wrote:

> I have a question about soc jack. I know the soc jack reports the jack 
> status when the jack status is change only. For example when the jack 
> is inserted or released, the soc jack reports the jack status to user 
> via input subsystem.

> But i want to know the jack status always regardless of the event to 
> insert or release a jack. For example we can check the jack status 
> always if the jack status is reported via sysfs file.

> So, is there how to know the jack status always the currently?

You can query this with an ioctl() on the input device - EVIOCGSW()
should do the trick, evtest.c has some example code I believe.  Adding
this information to sysfs would be nice if someone has the time to look
into it.
