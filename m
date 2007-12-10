From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: [alsa-cvslog] alsa-kernel: cmipci: disable "Modem"
	control on version 39 or newer chips
Date: Mon, 10 Dec 2007 18:23:56 +0100
Message-ID: <m23aua79ar.fsf@vador.mandriva.com>
References: <ALOGGER1197288764.96@alsa-project.org>
	<m2ve768zyk.fsf@vador.mandriva.com>
	<1197299427.3147.1225765285@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.mandriva.com (mx1.mandriva.com [212.85.150.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 80F2424474
	for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2007 18:24:33 +0100 (CET)
In-Reply-To: <1197299427.3147.1225765285@webmail.messagingengine.com> (Clemens
	Ladisch's message of "Mon\, 10 Dec 2007 16\:10\:27 +0100")
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

"Clemens Ladisch" <clemens@ladisch.de> writes:

> > > description:
> > > cmipci: disable "Modem" control on version 39 or newer chips
> > > 
> > > On version 39 or newer chips, we better remove the "Modem" control
> > > because this register bit now mutes the front channels of the
> > > multichannel stream.
> > 
> > shouldn't that deserve a comment in the code?
> 
> Not in my opinion.  The "if (version < 39)" makes clear in which
> version the control is used, and both the old and new bits are
> documented in the respective data sheets.

Still a comment would prevent forcing people do double check the data
sheets in order to understand the code...
