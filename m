From: Hannu Savolainen <hannu@opensound.com>
Subject: Re: Implementing ALSA compatibility in OSS
Date: Mon, 15 Nov 2004 14:29:31 +0200 (EET)
Message-ID: <Pine.LNX.4.58.0411151423370.9362@zeus.compusonic.fi>
References: <200411151125.iAFBPN9Z031710@www6.pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200411151125.iAFBPN9Z031710@www6.pobox.sk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 15 Nov 2004, Peter Zubaj wrote:

> Would be simpler and faster to implement only alsa-lib plugin as whole
> alsa-lib (I never tryed this) ????

> Look at pcm_jack.c (from alsa-lib) - this plugin implements output to
> jack from every alsa app (I think).
This approach sounds interesting. Unfortunately my impression after
looking at the code is that the plugin interface only works with PCM. Also
the library seems to be build tightly around ALSA kernel drivers and
taking ALSA's place as the "hardware" driver (for the default and hw:*
devices). However it would be be interesting to hear what ALSA's
developers say about this.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
