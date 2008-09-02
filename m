From: Jaroslav Kysela <perex@perex.cz>
Subject: Re:
 =?utf-8?q?alsa-lib=2C_dmix=2C_and_snd=5Fpcm=5Fopen?=
 =?utf-8?q?=5Fconf_function?=
Date: Tue, 2 Sep 2008 07:51:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0809020749470.9153@tm8103.perex-int.cz>
References: <loom.20080901T165414-425@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 1535E103807
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Sep 2008 07:51:03 +0200 (CEST)
In-Reply-To: <loom.20080901T165414-425@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Simon Tremblay <bidou@videotron.qc.ca>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 1 Sep 2008, Simon Tremblay wrote:

> Hi, 
> 
> I have a problem using dmix on my embedded system (manual installation of
> alsa-lib 1.0.15)
> 
> When I play a sound with aplay, it works well.
> 
> When I try -D dmix or -D plug:dmix parameter, it doesn't work. 
> 
> The output is: 
> 
> aplay: main:547: audio open error: Operation not permitted

strace will help you. I would look to ipc permissions (alsa.conf):

defaults.pcm.ipc_gid audio
defaults.pcm.ipc_perm 0660

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
