From: ozan <ozan@pardus.org.tr>
Subject: Re: Request for compilation test - v1.0.25
Date: Mon, 23 Jan 2012 16:44:24 +0200
Message-ID: <8b58ef2e6ba0ad6a3b42e7124911cd84@pardus.org.tr>
References: <4F1D405E.50301@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.pardus.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 2756024380
	for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2012 16:01:44 +0100 (CET)
In-Reply-To: <4F1D405E.50301@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

 On Mon, 23 Jan 2012 12:11:26 +0100, Jaroslav Kysela <perex@perex.cz> wrote:
> Hi all,
>
> 	I would like to ask for a package compilation test in your distribution
> for latest ALSA package snapshots available at:

> alsa-plugins 	1.0.24.11.gb3fb5

 alsa-plugins tarball doesn't contain the *.conf files for PulseAudio added 
 with the commit below:
   
 http://git.alsa-project.org/?p=alsa-plugins.git;a=commit;h=84ce9d8230d19ebd67bc8db691bab74c4cbac979

 Thus build fails as they're referenced in pulse/Makefile.*

 The other ones except alsa-oss which doesn't have a package in Pardus are 
 building just fine on x86_64 over linux 3.2.1 with GCC 4.5.3.

 Sound works as expected after a reboot.

 ---
 Ozan Caglayan
