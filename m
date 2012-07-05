From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Always call standard
	unsolicited event
Date: Thu, 05 Jul 2012 12:01:56 +0200
Message-ID: <4FF56614.10106@canonical.com>
References: <1341482413-7131-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id B1C9B244B0
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2012 12:01:56 +0200 (CEST)
In-Reply-To: <1341482413-7131-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, 1021192@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

On 07/05/2012 12:00 PM, David Henningsson wrote:
> With the model parsers out of the way, we have no custom unsol
> events to worry about, we can therefore simplify the code.
>
> In addition, this fixes a bug on the ASUS TC710, which has only
> a headphone jack and a mic jack, but no internal mic or speakers.
> Therefore the unsol_event pointer was not set, and as a result,
> the jack kcontrols were not correctly updated.
>
> BugLink: https://bugs.launchpad.net/bugs/1021192
> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
> ---
>
> Alsa-info:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1021192/+attachment/3213783/+files/eb1030-bad-alsa-info.log

Hmm, maybe the subject line should have said "ALSA: hda - Always call 
standard unsolicited event for Realtek codecs" for clarity.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
