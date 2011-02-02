From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-core: Support debugfs entries
 larger than PAGE_SIZE bytes
Date: Wed, 02 Feb 2011 13:28:16 +0000
Message-ID: <1296653296.4393.1.camel@dplaptop.localdomain>
References: <1296646145-2356-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<20110202130741.GP12743@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8F1CA2455E
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 14:30:24 +0100 (CET)
In-Reply-To: <20110202130741.GP12743@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam@alsa-project.org, Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-02-02 at 13:07 +0000, Mark Brown wrote:
> On Wed, Feb 02, 2011 at 11:29:05AM +0000, Dimitris Papastamos wrote:
> > +	if (ret >= 0) {
> > +		if (!access_ok(VERIFY_WRITE, user_buf, ret)) {
> > +			ret = -EFAULT;
> > +			goto out;
> > +		}
> > +		if (copy_to_user(user_buf, buf, ret)) {
> > +			ret = -EFAULT;
> > +			goto out;
> > +		}
> 
> Why do we need the access_ok() here?  I'd really expect copy_to_user()
> to do the right thing here and simple_read_from_buffer() doesn't do
> this.

I thought it'd be a problem if userspace provides a pointer that points
in kernelspace.  The call to access_ok() ensures that the pointer lies
indeed in userspace.  I noticed that simple_read_from_buffer() doesn't
do this, but I did not see how this could harm things.

Thanks,
Dimitris
