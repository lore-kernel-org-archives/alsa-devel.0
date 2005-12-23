From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: re: Envy24control -changes on screen
Date: Fri, 23 Dec 2005 17:50:22 +0000
Message-ID: <200512231750.22633.gineera@aspect135.co.uk>
References: <200512162315.43124.gineera@aspect135.co.uk> <s5hd5jpxgno.wl%tiwai@suse.de> <s5hacetxgfb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hacetxgfb.wl%tiwai@suse.de>
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

On Thursday 22 December 2005 16:08, you wrote:
> At Thu, 22 Dec 2005 17:03:55 +0100,
>
> I wrote:
> > Hi,
> >
> > thanks for the patch.  Just a few nitpicks...
> >
> >
> > At Fri, 16 Dec 2005 23:15:43 +0000,
> >
> > Alan Horstmann wrote:
> > > -		sprintf(str, "S/PDIF Out %s", stream & 1 ? "L": "R");
> > > +		sprintf(str, "SPDIF Out %s", stream & 1 ? "L": "R");
> >
> > I thought "S/PDIF" is the correct word...

The change here is to shorten the label by one character, just enough to 
prevent those 2 meters being wider than the others, which is noticable when 
using eg a 2-channel wide window and scrolling along the meters.  (I have 
narrowed the meters.)  I think the meaning is unambiguous without the '/', 
although I accept it is a compromise.

> > > +	/* build scrolling area */
> > > +	scrolledwindow = gtk_scrolled_window_new(NULL, NULL);
> > > +	gtk_widget_show(scrolledwindow);
> > > +	gtk_box_pack_start(GTK_BOX(hbox), scrolledwindow, TRUE, TRUE, 0);
> > > +	gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scrolledwindow),
> > > +					GTK_POLICY_ALWAYS, GTK_POLICY_NEVER);
> >
> > Wouldn't GTK_POLICY_AUTOMATIC be better?
> > Some boards have only 2 or 4 channels.

That section is simply a copy of what exists at present in envy24control.c in 
3 places.  I notice from the bug-track that 0001664 'GTK2-patch for 
envy24control' includes just this change to the existing scroll-windows; will 
this be applied?  I think it might be preferable to fix all the occurances as 
appropriate with a separate patch afterwards?

> Also, I got many compile warnings after your patch.  Could you fix
> them, too?

I have no warnings at all (otherwise the patch would not have been submitted).  
Can you list them and I will have a go.

Alan



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
