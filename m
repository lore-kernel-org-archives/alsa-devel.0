From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Sat, 14 Jun 2008 10:51:10 +0100
Message-ID: <4853948E.3040508@superbug.co.uk>
References: <20080609190225.GA4534@tango.0pointer.de>	<s5h1w333o7r.wl%tiwai@suse.de>	<20080612205225.GB20818@tango.0pointer.de>	<s5hd4mlhlau.wl%tiwai@suse.de>	<20080613142526.GB21255@tango.0pointer.de>	<s5hod65qqhh.wl%tiwai@suse.de>
	<20080613182234.GB1335@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-33.mail.demon.net (anchor-post-33.mail.demon.net
	[194.217.242.91])
	by alsa0.perex.cz (Postfix) with ESMTP id D8DB110380F
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Jun 2008 11:51:12 +0200 (CEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[127.0.0.1])
	by anchor-post-33.mail.demon.net with esmtp (Exim 4.67)
	id 1K7SPg-000MO3-Am
	for alsa-devel@alsa-project.org; Sat, 14 Jun 2008 09:51:12 +0000
In-Reply-To: <20080613182234.GB1335@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lennart Poettering wrote:
> I could agree to that. However, to be useful it must be possible to
> query those three pointers atomically. i.e. in a single call:
>
>    typedef struct snd_ptr_info {
>         snd_uframes_t curr_ptr;
>         snd_uframes_t hw_ptr;
>         snd_uframes_t appl_ptr;
>    } snd_ptr_info_t;
>
>    int snd_pcm_get_ptr_info(snd_pcm_t *pcm, snd_ptr_info_t *i);
>
>   

We would have to be careful. The current snd_pcm_delay() sorts out all 
the wrap around detection etc. for us.
Having the raw pointers would require the application to do the wrap 
around detection but the driver has extra information in order for it to 
detect wrap around.
