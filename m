From: Jurgen Kramer <gtmkramer@xs4all.nl>
Subject: Re: [PATCH v2] add native DSD support for XMOS based
 DACs
Date: Fri, 05 Sep 2014 17:41:13 +0200
Message-ID: <1409931673.2732.6.camel@xs4all.nl>
References: <1409919897-7040-1-git-send-email-gtmkramer@xs4all.nl>
 <5409D622.7050509@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr9.xs4all.nl (smtp-vbr9.xs4all.nl [194.109.24.29])
 by alsa0.perex.cz (Postfix) with ESMTP id E81402619EA
 for <alsa-devel@alsa-project.org>; Fri,  5 Sep 2014 17:41:14 +0200 (CEST)
In-Reply-To: <5409D622.7050509@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2014-09-05 at 17:26 +0200, Clemens Ladisch wrote:
> Jurgen Kramer wrote:
> > +	/* XMOS based USB DACs */
> > +	if (le16_to_cpu(chip->dev->descriptor.idVendor) == 0x20b1) {
> > +		switch (le16_to_cpu(chip->dev->descriptor.idProduct)) {
> > +		/* iFi Audio micro/nano iDSD */
> > +		case 0x3008:
> 
> And you don't need to go through the descriptors; you can test
> chip->usb_id directly (see snd_usb_set_format_quirk()).
Thanks, will do!

Jurgen
