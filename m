From: Kristof vansant <de_lupus@pandora.be>
Subject: Re: alsa-drivers can't make on kernel 2.6 because of
	broken vx driver
Date: Tue, 06 Jan 2004 15:27:11 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1073399231.2633.35.camel@d51528079.kabel.telenet.be>
References: <1073392202.2633.4.camel@d51528079.kabel.telenet.be>
	 <06a601c3d45c$f9290280$5d40a8c0@FRiskMan.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <06a601c3d45c$f9290280$5d40a8c0@FRiskMan.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

That's a work around not a fix :p :)

./configure --with-cards=driver_name

does the trick to but it's not a fix :)

Lupus (Kristof Vansant)

Op di 06-01-2004, om 14:56 schreef Ed Wildgoose:
> > I don't know how alsa patches drivers when it has to compile on kernel
> > 2.6, so I don't know how to fix it.
> 
> See my message in Alsa-Users posted a few hours ago with title: "Can not
> patch 2.6 kernel"
> 
> The answer is listed on the first page of the alsa website in fact! I failed
> to read it at first, however, basically you apply the drivers to your 2.6
> kernel and recompile the kernel.  Just done it and everything seems to be
> working nicely
> 
> Good luck
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
> 



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
