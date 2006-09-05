From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [RFC] Extra info via the TLV interface
Date: Tue, 5 Sep 2006 08:30:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0609050818500.9338@tm8103.perex-int.cz>
References: <44FC20B0.4060501@superbug.co.uk> <s5h8xkzlnxn.wl%tiwai@suse.de>
	<44FC46C0.30807@superbug.co.uk> <s5hy7szk59w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hy7szk59w.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 4 Sep 2006, Takashi Iwai wrote:

> Sorry, I meant to re-define every control "name" that is not
> conforming in the above.  Renaming a mixer element _always_ results in
> a name mismatch _error_ in alsactl.  It's handled as an error, not a
> warning.

Note that alsactl or probably alsa-lib should be improved. We cannot 
expect that names won't change and name cleanups are preferred. I would 
propose to create a database with name change description to prevent these 
errors and allow users switching between two ALSA driver versions more 
nicely.

The question is, if applications use these names to do something special
(if they compares them with own strings). Of course, we will break the 
compatibility in this case. I would like to discuss, if adding a function
like

int snd_mixer_compat_control_name(const char *name,
				  const char *alsa_version,
			          char *new_name, int new_name_size)

would be sufficient to ALSA API.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
