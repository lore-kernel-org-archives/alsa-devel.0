From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [PATCH] emu10k1: minor send routing cleanup
Date: Sat, 20 Nov 2004 18:29:19 -0500
Message-ID: <1100993359.2927.2.camel@krustophenia.net>
References: <1100645745.17573.6.camel@krustophenia.net>
	 <s5hk6sksihs.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk6sksihs.wl@alsa2.suse.de>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Wed, 2004-11-17 at 14:38 +0100, Takashi Iwai wrote:
> > 
> > Use snd_emu10k1_compose_audigy_fxrt* macro where appropriate.  Also add
> > a few comments to explain send routing structure.
> > 
> > Signed-Off-By: Lee Revell <rlrevell@joe-job.com>
> 
> Thanks, applied to CVS.
> 

Sorry, please revert this one.  It disables the right channel.  The
macro must not be correct.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
