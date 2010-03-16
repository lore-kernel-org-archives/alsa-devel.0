From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: underrun problem when short audio play
Date: Tue, 16 Mar 2010 13:35:58 +0000
Message-ID: <20100316133557.GA8967@rakim.wolfsonmicro.main>
References: <19320030.825861268745186292.JavaMail.weblogic@epml03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6CDD5243D3
	for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2010 14:35:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <19320030.825861268745186292.JavaMail.weblogic@epml03>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ANISH KUMAR <anish.singh@samsung.com>
Cc: MAHAMMADRAFI MANIYAR <maniyar@samsung.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 16, 2010 at 01:13:06PM +0000, ANISH KUMAR wrote:

[Reflowed into 80 columns for legibility, please take a look at
Documentation/email-clients.txt.]

> This causes write call to get blocked in playback case causing application to hangup.
> This doesn't happen if we don't go to sleep.
> So i think somewhere there is some problem with suspend->resume case which is difficult to figure out.

You hadn't mentioned suspend and resume before...  Are you sure that the
drivers you are using implement suspend and resume at all?  Which
drivers are you using - this is likely to be a driver or system specific
issue from what you say above?
