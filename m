From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: Re: [PATCH] ALSA: hda - apply CS420X erratum fix for
 CS4207 only
Date: Thu, 03 Mar 2011 10:57:26 +0530
Message-ID: <1299130046.5858.8.camel@snowflake>
References: <C9941A81.3C4F%brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.128.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 203C3103819
	for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2011 06:27:33 +0100 (CET)
In-Reply-To: <C9941A81.3C4F%brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Austin, Brian" <Brian.Austin@cirrus.com>
Cc: Arun@alsa-project.org, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Raghavan <arun@accosted.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-03-02 at 22:03 +0000, Austin, Brian wrote:
> That should not happen. This sequence was tested on all version of cs420x
> 
> Is there some output of the failure you can report?

I haven't seen any output on failure (other than the fact that the
digital out never comes on if this sequence is used). My hardware is a
MacBook Pro 5.5 (and another person sees this line causing the same
issue for them on the MBP .62 as well).

-- Arun
