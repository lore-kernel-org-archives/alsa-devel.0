From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Use-before-initialization in alsa-oss
Date: Sat, 6 Oct 2007 19:33:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0710061932580.13710@tm8103.perex-int.cz>
References: <47076099.40609@ums.usu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 56F152468B
	for <alsa-devel@alsa-project.org>;
	Sat,  6 Oct 2007 19:33:12 +0200 (CEST)
In-Reply-To: <47076099.40609@ums.usu.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 6 Oct 2007, Alexander E. Patrakov wrote:

> dsp->oss_format was used before it was set correctly
> 
> spotted by running "aoss flite_time 10:00"
> Signed-Off-By: Alexander E. Patrakov

Applied. Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
