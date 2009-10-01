From: "Munzir Taha (=?utf-8?q?=D9=85=D9=86=D8=B0=D8=B1?=
	=?utf-8?q?_=D8=B7=D9=87?=)" <munzirtaha@gmail.com>
Subject: Re: My Codec: IDT 92HD75B3X5 issues
Date: Fri, 2 Oct 2009 01:11:01 +0300
Message-ID: <200910020111.01552.munzirtaha@gmail.com>
References: <200909300818.31295.munzirtaha@gmail.com>
	<s5h3a63mec7.wl%tiwai@suse.de> <s5hk4zfi39r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id D1E5A24628
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Oct 2009 00:11:06 +0200 (CEST)
Received: by bwz25 with SMTP id 25so1519891bwz.32
	for <alsa-devel@alsa-project.org>; Thu, 01 Oct 2009 15:11:05 -0700 (PDT)
In-Reply-To: <s5hk4zfi39r.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Yaum al-Khamees 11 Shawwal 1430 5:42:56 pm Takashi Iwai wrote:

> I found the culprit.  It's actually a bug happening between the analog
> and the digital mic switches.
> Try the patch below.
> 
> 
> Takashi


Dear Takashi,
To complete this thread, what about missing options like
1. Disabling "Headphone Jack Sense" to allow both speakers and headphones to 
work together in case

2. jack retasking where I can plug my mic in the headphone jack and expect it 
to work

2. Capture boost

-- 
Munzir Taha
Telecommunications and Electronics Engineer
Master CIW Designer, ICDL, MOUS, Linux+, LPI, SCSA
Riyadh, SA
