From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: envy24control and gtk2
Date: 25 Mar 2003 11:41:03 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048621263.26669.34.camel@cmn37.Stanford.EDU>
References: <1048462242.1151.40.camel@v304.herlevkollegiet.dk>
	<s5hbrzzpcpn.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbrzzpcpn.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: =?ISO-8859-1?Q?S=F8ren?= Wedel Nielsen <swn@herlevkollegiet.dk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > I have upgraded the envy24control program to use gtk2.
> > To make the layout work I have changed it from fixed to hbox/vbox, but I
> > have tried not to change the structure og the gui-file envy24control.c.
> > It will also work with gtk1.
> > 
> > http://www.heko.dk/~swn/envy24control/envy24control-hboxvbox-230303.patch
> 
> thanks, i applied this to cvs.
> 
> > To get it to use gtk2 I have changed the build configuration files.
> > 
> > http://www.heko.dk/~swn/envy24control/envy24control-gtk2-230303.patch
> 
> this is not yet - i suppose many users still stick with gtk1.2.
> would it be better to put the patch on cvs?

Is this an option or mandatory? Will the program still build on gtk1.2?
Otherwise (for example) users of redhat 7.2 will not be able to compile
envy24control...

-- Fernando




-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
