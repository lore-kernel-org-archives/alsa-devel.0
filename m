From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] display EFGH sends in proc file for audigy
Date: Wed, 17 Nov 2004 18:48:15 -0500
Message-ID: <1100735296.1428.19.camel@krustophenia.net>
References: <1100719069.6930.38.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1100719069.6930.38.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: Takashi Iwai <tiwai@suse.de>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 2004-11-17 at 14:17 -0500, Lee Revell wrote:
> This patch adds display of sends EFGH in the /proc file.

Disregard this patch.  It has a stupid typo, and besides it turns out
the display of EFX send routing in the /proc file was bogus to begin
with.  This is a per channel register, but it is only ever displayed for
channel 0.  Not very useful.

I will incorporate a fix for this into the per channel register dump
patch.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
