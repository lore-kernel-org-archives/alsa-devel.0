From: Mark Knecht <markknecht@comcast.net>
Subject: Re: snd-rme9652 fails
Date: Mon, 22 Dec 2003 04:58:21 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1072097901.1852.9.camel@Wizard.knechthome.com>
References: <200312221238.hBMCcqlt015332@dhin.linuxaudiosystems.com>
	 <Pine.LNX.4.58.0312221340010.8959@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0312221340010.8959@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2003-12-22 at 04:43, Jaroslav Kysela wrote:
> > how did this code imply a duplicate control? removing it is
> > *wrong*, utterly wrong. it is an important control for some purposes.
> 
> It seems that this control is available only for 9652 not for 9632 
> version. The same control was used and defined twice for 9652 while with 
> 9632 was probably useless:
> 

9632 or 9636? Doesn't the 9632 use a different driver? (snd-hdsp?)

I reported a bug long ago about the /proc file system for the Hammerfall
Light (9636) showing ADAT3 for sync instead of spdif. Maybe this is
related?



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
