From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: fix incorrect mixer index values for
	92hd83xx
Date: Sat, 20 Dec 2008 17:56:35 -0500
Message-ID: <494D7823.2000809@embeddedalley.com>
References: <494D75FC.1030904@embeddedalley.com> <s5habaq791n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 8FB831037E3
	for <alsa-devel@alsa-project.org>; Sat, 20 Dec 2008 23:56:43 +0100 (CET)
In-Reply-To: <s5habaq791n.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
> At Sat, 20 Dec 2008 17:47:24 -0500,
> Matthew Ranostay wrote:
>> Fixed incorrect mixer index values for 92hd83xx codec's audio
>> input mixer.
>>
>> Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
> 
> Applied this one, too.
> 
> Regarding this change: what I've been concerned by the recent
> patch_sigmatel.c are that the input routes are fixed, and capture
> mixer elements are often too messy and not intuitive.
> 
Yeah, there has to be better way to do this.

> Hopefully we can sort out these later...
> 
> 
> Thanks,
> 
> Takashi
> 
