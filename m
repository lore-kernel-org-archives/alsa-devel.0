From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 05/20] ALSA: firewire-speakers: remove
	__dev* attributes
Date: Thu, 06 Dec 2012 19:13:26 +0100
Message-ID: <50C0E046.10207@ladisch.de>
References: <1354815329-20221-1-git-send-email-wfp5p@virginia.edu>
 <1354815329-20221-6-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 4B73B26171E
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2012 19:13:52 +0100 (CET)
In-Reply-To: <1354815329-20221-6-git-send-email-wfp5p@virginia.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: tiwai@suse.de, gregkh@linuxfoundation.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option.  As result the __dev*
> markings will be going away.
>
> Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
> and __devexit.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Clemens Ladisch <clemens@ladisch.de>

Acked-by: Clemens Ladisch <clemens@ladisch.de>
for all these (5,10,11):

>  sound/firewire/speakers.c        | 8 ++++----

>  sound/pci/bt87x.c                | 22 +++++++++++-----------

>  sound/pci/oxygen/oxygen.c        | 10 +++++-----
>  sound/pci/oxygen/virtuoso.c      | 10 +++++-----
>  sound/pci/oxygen/xonar_cs43xx.c  |  4 ++--
>  sound/pci/oxygen/xonar_pcm179x.c |  4 ++--
>  sound/pci/oxygen/xonar_wm87x6.c  |  4 ++--
