From: Jeremy Hall <jhall@maoz.com>
Subject: Re: CVS server problems: old RCS files corrupted
Date: Tue, 18 Nov 2003 05:43:23 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311181043.hAIAhNM3007215@sith.maoz.com>
References: <s5hptfqhsez.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hptfqhsez.wl@alsa2.suse.de> from Takashi Iwai at "Nov 18, 2003
 11:39:32 am"
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Sergey Vlasov <vsu@altlinux.ru>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

What about the ones on alsa-project, was it _THAT_ long ago?

_J

In the new year, Takashi Iwai wrote:
> At Mon, 17 Nov 2003 18:33:35 +0300,
> Sergey Vlasov wrote:
> > 
> > [1  <text/plain; us-ascii (7bit)>]
> > Hello!
> > 
> > I have tried to look at the ALSA CVS log through the anonymous CVS access
> > (using recursive 'cvs log'), but encountered several errors in old files
> > (which no longer exist in the current version):
> > 
> > cvs [server aborted]: unrecognized operation '\x9' in /cvsroot/alsa/alsa-driver/kernel/Attic/mixer.c,v
> > 
> > cvs server: warning: duplicate key `log' in version `1.33' of RCS file `/cvsroot/alsa/alsa-driver/lowlevel/isa/Attic/es1688.c,v'
> > cvs server: warning: duplicate key `text' in version `1.33' of RCS file `/cvsroot/alsa/alsa-driver/lowlevel/isa/Attic/es1688.c,v'
> > ...
> > cvs [server aborted]: invalid rcs file /cvsroot/alsa/alsa-driver/lowlevel/isa/Attic/es1688.c,v: premature end of value
> > 
> > Tried the backup server too - no difference.  Probably the files have been
> > corrupted?
> 
> looks like so.  possibly the filesystem on sf server was corrupt.
> i guess it's not easy to repair this kind of failures.
> 
> 
> Takashi
> 
> 
> -------------------------------------------------------
> This SF. Net email is sponsored by: GoToMyPC
> GoToMyPC is the fast, easy and secure way to access your computer from
> any Web browser or wireless device. Click here to Try it Free!
> https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
