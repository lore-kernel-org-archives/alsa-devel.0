From: Allan Klinbail <allank@labyrinth.net.au>
Subject: Re: Re: will this work? substitution of files.
Date: 18 Feb 2003 00:19:22 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045487969.16628.95.camel@littlewolf2.littlewolf>
References: <1045463580.16502.3.camel@littlewolf2.littlewolf>
	<1045463676.16503.5.camel@littlewolf2.littlewolf>
	<1045487711.16502.92.camel@littlewolf2.littlewolf>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1045487711.16502.92.camel@littlewolf2.littlewolf>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-dev <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


 Silly me!!! 
 All I needed to do was place the cvs version of mtpav.o into 
 /lib/modules/2.4.20/kernel/sound/drivers/snd-mtpav.o
 after being compiled and place it over the one from the released
 version. Now I can continue testing the mtpav driver (fingers crossed)  
 
 I still have a problem compiling the CVS version alsa-lib (see other
 posting)
 
 cheers
 
 Allan 
> 
> On Mon, 2003-02-17 at 17:34, Allan Klinbail wrote:
> > On Mon, 2003-02-17 at 17:32, Son of Zev wrote:
> > > Hi 
> > > 
> > > While I am trying to sort out why I can't succesfully install the cvs
> > > version .. will substituing the updates mtpav files from the cvs version
> > > to the last release version work?
> > > 
> > > cheers
> > > 
> > > Allan Klinbail 
> > > 
> > > 
> > 
> > If the answer is yes.. please let me know whcih files I need to
> > substitute.. there seems to be many
> > 
> > cheers
> > 
> > ALlan 
> > 
> > 
> > 
> > 
> > -------------------------------------------------------
> > This sf.net email is sponsored by:ThinkGeek
> > Welcome to geek heaven.
> > http://thinkgeek.com/sf
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
