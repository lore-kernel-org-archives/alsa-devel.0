From: thomas charbonnel <thomas@undata.org>
Subject: Re: hdsp fixes
Date: Thu, 27 Jan 2005 22:42:28 +0100
Message-ID: <1106862148.11014.17.camel@localhost>
References: <1106761331.11426.17.camel@localhost>
	 <s5hekg6oiel.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hekg6oiel.wl@alsa2.suse.de>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote :
> Hi,
> 
> the following are some things I noticed in the patch:
> 
> 
> > +#define HDSP_PRECISE_POINTER(xname, xindex) \
> >  { .iface = SNDRV_CTL_ELEM_IFACE_HWDEP, \
> >    .name = xname, \
> >    .index = xindex, \
> > -  .info = snd_hdsp_info_line_out, \
> > -  .get = snd_hdsp_get_line_out, \
> > -  .put = snd_hdsp_put_line_out \
> > +  .info = snd_hdsp_info_precise_pointer, \
> > +  .get = snd_hdsp_get_precise_pointer, \
> > +  .put = snd_hdsp_put_precise_pointer \
> 
> Do we need this as a control?
> Isn't preceise_ptr reliable?
> 

It should be reliable now. It was not for the rme9652, and the hdsp code
forked from there. It was badly broken until recently (Ed Wildgoose's
patch, IIRC), and I think few people tried it (it defaulted to off). We
don't really need it as a control, but I thought it would be easier for
people to test this way. If it proves reliable, I'll eventually remove
the alternative code.
Incidentally, I just sent a new patch without seeing your mail... I'm
affraid you won't be fond of the new "use midi tasklet" ctl :)

> > +	if (!is_9652 && !is_9632) {
> > +		/* we wait 2 seconds to let freshly inserted cardbus cards do their hardware init */
> > + 		if ((1000 / HZ) < 2000) {
> > +			set_current_state(TASK_UNINTERRUPTIBLE);
> > +			schedule_timeout((2000 * HZ + 999) / 1000);
> > +		} else {
> > +			mdelay(2000);
> > +		}
> 
> You can use ssleep(2) here.
> 

Sure, I didn't know about it.
There is another instance in the code that could use ssleep also.

Thanks,
Thomas




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
