From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 2/2] alsaucm: Don't double-free empty lists
Date: Fri, 03 Jun 2011 11:50:07 +0200
Message-ID: <4DE8AE4F.5020708@perex.cz>
References: <1307054713-32228-1-git-send-email-swarren@nvidia.com>
	<1307054713-32228-2-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E34D103942
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jun 2011 11:50:08 +0200 (CEST)
In-Reply-To: <1307054713-32228-2-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Date 3.6.2011 00:45, Stephen Warren wrote:
> When snd_use_case_get_list (and hence also snd_use_case_card_list) returns
> an empty list, alsaucm still attempts to free it. This ends up double-
> freeing the returned list, or worse, freeing an invalid pointer, depending
> on how snd_use_case_get_list gets implemented. Fix alsaucm to return early
> on empty lists to avoid this.

All four UCM patches were applied to our GIT repos.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
