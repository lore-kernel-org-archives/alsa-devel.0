From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Terratec DMX6fire control signal
Date: Tue, 22 Nov 2005 14:30:39 +0000
Message-ID: <200511221430.39096.gineera@aspect135.co.uk>
References: <200511211515.38896.gineera@aspect135.co.uk> <200511212255.56749.gineera@aspect135.co.uk> <s5hmzjwnccz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hmzjwnccz.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tuesday 22 November 2005 11:36, Takashi Iwai wrote:
> At Mon, 21 Nov 2005 22:55:56 +0000,
>
> Alan Horstmann wrote:
> > On Monday 21 November 2005 15:15, I wrote:
> > > I have been working on some patches for the Terratec DMX6fire.  The
> > > control signal 'Front Digital Input Switch' in alsamixer acts in
> > > reverse.  Is it better to rename it the opposite logic (which in this
> > > case might be 'Internal Digital Input Switch') or reverse its action in
> > > the route that the control connects to the hardware?
> >
> > ....Or the invert parameter could be set when the control is created, I
> > just noticed?  It seems to do the job.
>
> I think simply fixing the driver would be easiest as below.
>
>
> Takashi
>
That's exactly what I meant by the 'invert parameter'; I confirm this corrects 
the problem.  Will you apply this to mainstream or should I present the patch 
on this list, with signed off line etc?  Note that this control is specific 
to the DMX6fire, and without other patches I am preparing it does not work 
from envy24control, so reversing it now should have no bad consequences. Once 
this is in place I can patch 'e24c' for the corrected action.
>
> Index: alsa-kernel/pci/ice1712/ews.c
> ===================================================================
> RCS file: /home/iwai/cvs/alsa/alsa-kernel/pci/ice1712/ews.c,v
> retrieving revision 1.25
> diff -u -r1.25 ews.c
> --- alsa-kernel/pci/ice1712/ews.c	17 Nov 2005 14:54:26 -0000	1.25
> +++ alsa-kernel/pci/ice1712/ews.c	22 Nov 2005 11:35:51 -0000
> @@ -917,7 +917,7 @@
>  		.get = snd_ice1712_6fire_select_input_get,
>  		.put = snd_ice1712_6fire_select_input_put,
>  	},
> -	DMX6FIRE_CONTROL("Front Digital Input Switch", 2, 0),
> +	DMX6FIRE_CONTROL("Front Digital Input Switch", 2, 1),
>  	// DMX6FIRE_CONTROL("Master Clock Select", 3, 0),
>  	DMX6FIRE_CONTROL("Optical Digital Input Switch", 4, 0),
>  	DMX6FIRE_CONTROL("Phono Analog Input Switch", 5, 0),
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
> Register for a JBoss Training Course.  Free Certification Exam
> for All Training Attendees Through End of 2005. For more info visit:
> http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
