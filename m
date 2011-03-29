From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH alsa-python] alsamixer: Fix bad
 PyArg_ParseTuple format strings
Date: Tue, 29 Mar 2011 08:51:57 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1103290851290.4805@eeebox2.perex-int.cz>
References: <20110328174633.GI29800@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id A3A3C24158
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Mar 2011 08:51:57 +0200 (CEST)
In-Reply-To: <20110328174633.GI29800@alittletooquiet.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Forest Bond <forest@alittletooquiet.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 28 Mar 2011, Forest Bond wrote:

> A number of calls to PyArg_ParseTuple use "I" for ints and "L" for
> long ints.  Fix these to be "i" and "l" respectively.

Applied. Thanks.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
