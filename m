From: John Lindgren <john.lindgren@tds.net>
Subject: Re: [PATCH] alsa-lib: snd_pcm_delay and friends do not
 account for a write being currently in progress
Date: Thu, 03 Jun 2010 10:00:48 -0400
Message-ID: <1275573648.1415.6.camel@satellite>
References: <1275514176.8032.42.camel@satellite> <4C074E63.90508@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A320103AAB
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 16:00:56 +0200 (CEST)
Received: by iwn35 with SMTP id 35so88517iwn.38
	for <alsa-devel@alsa-project.org>; Thu, 03 Jun 2010 07:00:55 -0700 (PDT)
In-Reply-To: <4C074E63.90508@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for your reply.

On Thu, 2010-06-03 at 08:40 +0200, Clemens Ladisch wrote:
> John Lindgren wrote:
> > In a multi-threaded application it is possible for snd_pcm_delay or an
> > equivalent function to be called by one thread while another is sitting
> > in snd_pcm_writei.
> 
> Alsa-lib is not thread safe.  In theory, you are not even allowed to
> call snd_pcm_delay while another function on the same PCM device has not
> yet returned.

>From http://alsa-project.org/main/index.php/Main_Page:

        ALSA has the following significant features:
        ...
        SMP and thread-safe design.

So, that's a big lie?

> ...
> > On the application side, the playback time counter will be calculated
> > during this time as 0.5 seconds written to ALSA
> 
> This is wrong; as long as the write call has not returned, you do not
> know how much has been written (and when an error occurs, writing can
> stop before).
> 
> To keep track of the actual amount of data written, use non-blocking
> mode and in a loop, write as much as possible in one call, then update
> your write counter, then wait for some more free space in the buffer
> with poll().

Would it work to simply call snd_pcm_wait?

John Lindgren
