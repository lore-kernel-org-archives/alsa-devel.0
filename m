From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/4] USB: Add endpoint usage definitions to
	ch9.h
Date: Wed, 14 Sep 2011 14:54:47 +0200
Message-ID: <20110914125447.GA8782@suse.de>
References: <1315846453-5036-1-git-send-email-zonque@gmail.com>
	<1315846453-5036-2-git-send-email-zonque@gmail.com>
	<CACTFLAM1bFzURnh-fqgqxU+HWvtW76ktc4-UN2BDFa_HLQ5ENQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 887A0103ABB
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 14:54:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CACTFLAM1bFzURnh-fqgqxU+HWvtW76ktc4-UN2BDFa_HLQ5ENQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 12, 2011 at 07:13:32PM +0200, Daniel Mack wrote:
> On Mon, Sep 12, 2011 at 6:54 PM, Daniel Mack <zonque@gmail.com> wrote:
> > The endpoint usage field is described in the USB 2.0 specification,
> > chapter 9.6.6.
> >
> > Also, move the sync type fields block down by some lines to reflect the
> > fact that these are also stuffed in bmAttributes.
> 
> Greg - can we merge this through the ALSA tree?

Yes, please do:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
