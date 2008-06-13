From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Fri, 13 Jun 2008 20:22:34 +0200
Message-ID: <20080613182234.GB1335@tango.0pointer.de>
References: <20080609190225.GA4534@tango.0pointer.de>
	<s5h1w333o7r.wl%tiwai@suse.de>
	<20080612205225.GB20818@tango.0pointer.de>
	<s5hd4mlhlau.wl%tiwai@suse.de>
	<20080613142526.GB21255@tango.0pointer.de>
	<s5hod65qqhh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 4CFC3103834
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 20:22:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hod65qqhh.wl%tiwai@suse.de>
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

On Fri, 13.06.08 17:55, Takashi Iwai (tiwai@suse.de) wrote:

> What about just providing three pointers: curr_ptr, hw_ptr and
> appl_ptr?  curr_ptr corresponds to the point being played, and hw_ptr
> is the point where the data was already sent to h/w, and appl_ptr is
> the point where the data is filled by user.  The above definitions are
> all combinations of these pointers.

I could agree to that. However, to be useful it must be possible to
query those three pointers atomically. i.e. in a single call:

   typedef struct snd_ptr_info {
        snd_uframes_t curr_ptr;
        snd_uframes_t hw_ptr;
        snd_uframes_t appl_ptr;
   } snd_ptr_info_t;

   int snd_pcm_get_ptr_info(snd_pcm_t *pcm, snd_ptr_info_t *i);

> I really don't understand why we need to hide hw_ptr and appl_ptr in
> the current API.  To me, exposing these points is much more
> straightforward.

I think I could subscribe to that.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
