From: "D. Hugh Redelmeier" <hugh@mimosa.com>
Subject: Re: newbie problem with control settings
Date: Thu, 31 Mar 2005 14:07:17 -0500 (EST)
Message-ID: <Pine.LNX.4.61.0503311400560.4699@redshift.mimosa.com>
References: <Pine.LNX.4.61.0503230124420.5926@redshift.mimosa.com>
 <s5hvf7ikzhb.wl@alsa2.suse.de> <s5hd5tiigf2.wl@alsa2.suse.de>
Reply-To: "D. Hugh Redelmeier" <hugh@mimosa.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd5tiigf2.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
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

| From: Takashi Iwai <tiwai@suse.de>

| > >     Line-in jack is:
| > > 
| > >     [*] Line-in
| > >     [ ] bass output
| > >     [ ] rear Left and Right output
| > 
| > This sounds nice.  The (untested) patch below changes the handling of
| > these controls as you proposed.
| 
| Can any one test the patch?

Thanks very much for this patch.  Unfortunately I am unable to test
it.

I do have a question about the patch.  How is a mixer supposed to find
out the names of the three possible values?  I see that there is a new
control named "Mic-In Mode" but I don't see where the possible
settings are described.


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
