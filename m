From: Greg KH <greg@kroah.com>
Subject: Re: sysfs: WARNING: at fs/sysfs/dir.c:424
	sysfs_add_one() - with	ALSA
Date: Fri, 26 Oct 2007 08:52:02 -0700
Message-ID: <20071026155202.GD23016@kroah.com>
References: <877aabc40710260014v220ab804o5de5dbc36b870bd1@mail.gmail.com>
	<20071026091722.GA21274@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 768F62417D
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Oct 2007 17:52:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071026091722.GA21274@linux.vnet.ibm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: alsa-devel@alsa-project.org, Amit Shah <amitshah@gmx.net>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 26, 2007 at 02:47:22PM +0530, Kamalesh Babulal wrote:
> I get similar warning, while loading the alsa driver

This is a different problem, not a rename issue like the network one
was.

> [  191.933548] Advanced Linux Sound Architecture Driver Version 1.0.15
> (Tue Oct 23 06:09:18 2007 UTC).
> [  191.996323] ALSA sound/core/seq/oss/seq_oss.c:232: can't register
> device seq
> [  192.046004] sysfs: duplicate filename 'audio' can not be created
> [  192.086048] WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()

This is an error in the alsa core, perhaps the alsa developers can help
figure out why they are registering the same file twice?

thanks,

greg k-h
