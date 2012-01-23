From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Request for compilation test - v1.0.25
Date: Mon, 23 Jan 2012 16:49:38 +0100
Message-ID: <4F1D8192.3070308@perex.cz>
References: <4F1D405E.50301@perex.cz>
	<8b58ef2e6ba0ad6a3b42e7124911cd84@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 1708924158
	for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2012 16:49:18 +0100 (CET)
In-Reply-To: <8b58ef2e6ba0ad6a3b42e7124911cd84@pardus.org.tr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ozan <ozan@pardus.org.tr>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Date 23.1.2012 15:44, ozan wrote:
>  On Mon, 23 Jan 2012 12:11:26 +0100, Jaroslav Kysela <perex@perex.cz> wrote:
>> Hi all,
>>
>> 	I would like to ask for a package compilation test in your distribution
>> for latest ALSA package snapshots available at:
> 
>> alsa-plugins 	1.0.24.11.gb3fb5
> 
>  alsa-plugins tarball doesn't contain the *.conf files for PulseAudio added 
>  with the commit below:
>    
>  http://git.alsa-project.org/?p=alsa-plugins.git;a=commit;h=84ce9d8230d19ebd67bc8db691bab74c4cbac979
> 
>  Thus build fails as they're referenced in pulse/Makefile.*

I fixed this issue in the commit bellow:

http://git.alsa-project.org/?p=alsa-plugins.git;a=commit;h=6c6a4e417e874f523435242129685eee656e79ab

alsa-plugins 	1.0.24.12.g6c6a4

Thank you for your report and test.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
