From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [RFC 01/16] ASoC: multi-component - AKM CODECs
Date: Fri, 25 Jun 2010 18:58:16 +0100
Message-ID: <1277488696.26730.951.camel@odin>
References: <1277488383-31287-1-git-send-email-lrg@slimlogic.co.uk>
	<1277488383-31287-2-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C5A8C103A96
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 19:58:17 +0200 (CEST)
Received: by wyf23 with SMTP id 23so170110wyf.38
	for <alsa-devel@alsa-project.org>; Fri, 25 Jun 2010 10:58:17 -0700 (PDT)
In-Reply-To: <1277488383-31287-2-git-send-email-lrg@slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-06-25 at 18:52 +0100, Liam Girdwood wrote:
> Move AKM CODECs to multi-component model.
> 
> This patch changes the probe() and remove() of the CODEC drivers as follows:-
> 
>  o Make CODEC driver a platform device (non MFD codecs only)

Oops, thought I'd removed the text in parenthesis. *All* CODECs are now
platform drivers.

Liam
