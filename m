From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ALSA calls don't work from a shared library
Date: Wed, 24 Aug 2011 13:42:25 +0200
Message-ID: <4E54E3A1.5090702@perex.cz>
References: <4E54E228.12224.FC4C70@olivier.myriad-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id B4B1110393A
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 13:42:26 +0200 (CEST)
In-Reply-To: <4E54E228.12224.FC4C70@olivier.myriad-online.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Olivier Guillion - Myriad <olivier@myriad-online.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Date 24.8.2011 13:36, Olivier Guillion - Myriad wrote:
> 
> Hi,
> 
> I opened a thread yesterday called "ALSA calls don't work within  Mozilla plug-
> ins", but after more testing, I realize that it is a more global problem, so I 
> submit another request for help with a proper title.

It looks like a linking (linker) issue. Are you sure that your dynamic
module is linked with libasound (-lasound option for gcc)?

The command "ldd <your_so_file>" should print libasound.so in list.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
