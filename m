From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Problem in dummy driver
Date: Wed, 21 Mar 2007 10:24:02 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0703211022190.8403@tm8103.perex-int.cz>
References: <46009856.4060601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 41B8A24398
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2007 10:24:03 +0100 (CET)
In-Reply-To: <46009856.4060601@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Himanshu Chauhan <hs.chauhan@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 21 Mar 2007, Himanshu Chauhan wrote:

> Dear all,
> 
> I am working on the dummy driver provided with the ALSA. I took it from
> the linux kernel 2.6.20.1
> I build the module and load it. The XMMS seems to play ok (doesn't hang
> and all) but none of
> the recording application seem to record from the driver.
> 
> Can the driver in current state work as the loop back cable between
> applications?

No, it's really dummy driver which eats playback samples and returns zero 
samples for capture. Try use the snd-aloop driver.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
