From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: mmotm 2010-08-11 - audio volume issues
Date: Thu, 12 Aug 2010 23:06:22 +0200
Message-ID: <4C64624E.7040002@gmail.com>
References: <201008112340.o7BNenDe021017@imap1.linux-foundation.org>
	<5043.1281639572@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 27BAB244E4
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 23:06:26 +0200 (CEST)
Received: by bwz10 with SMTP id 10so441916bwz.38
	for <alsa-devel@alsa-project.org>; Thu, 12 Aug 2010 14:06:25 -0700 (PDT)
In-Reply-To: <5043.1281639572@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Valdis.Kletnieks@vt.edu
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 08/12/2010 08:59 PM, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 11 Aug 2010 16:10:49 PDT, akpm@linux-foundation.org said:
>> The mm-of-the-moment snapshot 2010-08-11-16-10 has been uploaded to
>>
>>    http://userweb.kernel.org/~akpm/mmotm/
> 
> Something appears to be borked in the ALSA arena.  There's no actual volume coming
> out of the system, and 'alsamixer' is insisting that the volume slider only goes from 0
> to 10% or so, no further.  However, experimentation shows that the volume slider
> in 'xine' *does* affect the 'Amp-Out vals' lines, and alsamixer has *no* effect on
> what 'Amp-Out vals' lists.
> 
> A diff of alsa-info.sh for the two kernels shows them being identical, so I'm only
> attaching one copy.
> 
> It may be the weekend before I find time to do a bisection of this.

Didn't you (like some other people) get into the state where pulseaudio
doesn't work? It chooses as an output a dummy driver automatically, then
you can change volume, play sound, but actually it all goes to /dev/null.

It took me a while before I figured out that it's a "dummy" driver I
have in pulseaudio.

regards,
-- 
js
