From: Greg KH <gregkh@suse.de>
Subject: Re: [RFC/PATCH v7 01/12] media: Media device node
	support
Date: Thu, 6 Jan 2011 16:31:40 -0800
Message-ID: <20110107003140.GA3828@suse.de>
References: <0iuif2gxlcatpj50djfn40p8.1294359457034@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id DE07510392A
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2011 01:32:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <0iuif2gxlcatpj50djfn40p8.1294359457034@email.android.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andy Walls <awalls@md.metrocast.net>
Cc: alsa-devel@alsa-project.org, sakari.ailus@maxwell.research.nokia.com, broonie@opensource.wolfsonmicro.com, clemens@ladisch.de, linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Jan 06, 2011 at 07:24:27PM -0500, Andy Walls wrote:
> Why, yes, there is a standard:
> 
> http://pubs.opengroup.org/onlinepubs/009695399/functions/xsh_chap02_03.html
> 
> A somewhat verbose description of the errnos is in section 2.3.

Ah, so perhaps -ENXIO is the correct thing to return with here.

thanks,

greg k-h
