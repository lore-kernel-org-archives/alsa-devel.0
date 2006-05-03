From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Re: au88x0 Init before create components
Date: Wed, 3 May 2006 15:55:57 +0100
Message-ID: <200605031555.57152.gineera@aspect135.co.uk>
References: <200604261414.52173.gineera@aspect135.co.uk> <200605012217.48660.gineera@aspect135.co.uk> <s5hk693gveg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk693gveg.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net, manuel.jander@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wednesday 03 May 2006 13:11, you wrote:
> At Mon, 1 May 2006 22:17:48 +0100,
>
> Alan Horstmann wrote:
> >
> > Reduced patch is attached
>
> I think it's better to remove the card number from the shortname
> field.  You can add it at copying to rmidi->name, instead.

That is what the patch does -card number isn't added to shortname, but just 
rmidi->name.

Alan



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
