From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: idea for emu10k1 master volume
Date: Thu, 18 Nov 2004 07:47:37 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0411180746500.15401@pnote.perex-int.cz>
References: <1100712652.6930.22.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1100712652.6930.22.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, James Courtier-Dutton <James@superbug.co.uk>, Peter Zubaj <pzad@pobox.sk>
List-Id: alsa-devel@alsa-project.org

On Wed, 17 Nov 2004, Lee Revell wrote:

> While hacking the emu10k1 driver I think I found a good way to implement
> a master volume control.  There is a master attenuation control for each
> voice.  This is pretty much unused - currently you would have to start a
> PCM stream then use alsamixer to attenuate it, effectively no
> attenuation is ever used.
> 
> To implement master volume we just make one control that attenuates all
> PCM streams.

Bad idea. The abstract layer should be in alsa-lib.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
