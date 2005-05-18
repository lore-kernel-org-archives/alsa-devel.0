From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: IO plugin and multiple poll descriptors
Date: Wed, 18 May 2005 14:56:43 +0200
Message-ID: <1116421003.10063.243.camel@pegasus>
References: <1116173811.8886.55.camel@pegasus>
	 <s5h3bsmqlq2.wl@alsa2.suse.de> <1116335015.10063.91.camel@pegasus>
	 <s5h7jhxq15v.wl@alsa2.suse.de> <s5hu0l0okxs.wl@alsa2.suse.de>
	 <1116417943.10063.234.camel@pegasus>  <s5hsm0kogme.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsm0kogme.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Mailing List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

thanks for the answers.

> > What happens at the moment when I really return two poll_fd.

What about this one?

> > > This change breaks the compatibility with older versions.
> > > For the future compatibility, I added a new field to
> > > snd_pcm_ioplug_t.
> > 
> > Does it? If the new callbacks are not used you will fall back to poll_fd
> > and so no difference at all.
> 
> Well, I inserted in the middle, not at the end.

You are right. I always forget to think about binary compatibility ;)

> > And you never released a final version with IOPLUG support.
> 
> Yes.  I don't care the compatibility *now* at all.
> But, as I wrote, this is for *future* compatibility.  Once after
> 1.0.9-final is out, we should be careful about it.

I agree.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
