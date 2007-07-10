From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: dmix and sounds less than 64kb
Date: Tue, 10 Jul 2007 10:16:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0707101008440.7300@tm8103.perex-int.cz>
References: <61e8390b0707062028t63c913eeg1ab5a40f830af597@mail.gmail.com>
	<s5hir8tvrvt.wl%tiwai@suse.de>
	<61e8390b0707091240i657f82ev306ac851759c791f@mail.gmail.com>
	<Pine.LNX.4.61.0707100954280.7300@tm8103.perex-int.cz>
	<61e8390b0707100104v9e66c8fu1321c287d1b8ed5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 198871038B9
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2007 10:16:41 +0200 (CEST)
In-Reply-To: <61e8390b0707100104v9e66c8fu1321c287d1b8ed5e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Aaron \"Caustik\" Robinson" <caustik@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 10 Jul 2007, Aaron "Caustik" Robinson wrote:

> This is on an embedded ARM device, with a custom driver. That's 
> interesting. I never thought about the cache angle. Is there any sort of 
> hack I can put to check if that is the problem?

The cache flush method is quite CPU specific, you have to check datasheet.
But it's only guess and the problem might be somewhere else. I would 
compare samples DMA ring buffer in the user space and kernel space again. 
Also, put a debug lines to dmix plugin to detect where are samples written 
(to which pointer/area in the DMA ring buffer). dmix assumes that playback 
is running forever and tries to mix data in actual ring buffer position.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
