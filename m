From: Mohammad Bahathir Hashim <bahathir@gmail.com>
Subject: Re: [PATCH] ALSA: hda - apply CS420X erratum fix for
	CS4207 only
Date: Thu, 3 Mar 2011 04:58:19 +0000 (UTC)
Message-ID: <ikn75a$jrc$1@dough.gmane.org>
References: <1299102498-29063-2-git-send-email-arun.raghavan@collabora.co.uk>
	<C9941A81.3C4F%brian.austin@cirrus.com>
Reply-To: Mohammad Bahathir Hashim <bahathir@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 0639E103816
	for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2011 05:58:37 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Pv0cV-0006l1-Em
	for alsa-devel@alsa-project.org; Thu, 03 Mar 2011 05:58:35 +0100
Received: from 203.106.17.237 ([203.106.17.237])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 03 Mar 2011 05:58:35 +0100
Received: from bahathir by 203.106.17.237 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 03 Mar 2011 05:58:35 +0100
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
List-Id: alsa-devel@alsa-project.org

On 2011-03-02, Austin, Brian <Brian.Austin@cirrus.com> wrote:
> That should not happen. This sequence was tested on all version of cs420x
>
> Is there some output of the failure you can report?
>

Yes, no SPDIF out from my MBP 6,2 if the sequence is enabled. Then,
MBP  might be using special version of CS4206. :) If this is true,
then, exclude MacBookPro6,2 from loading the errata code.

Thank you.
