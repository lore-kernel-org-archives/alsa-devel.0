From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: =?utf-8?Q?=22soft=22?= spdiff support
Date: Mon, 15 Nov 2004 17:37:26 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411151736040.1491-100000@studcom.urz.uni-halle.de>
References: <courier.4198D779.00011623@outpost.mndmttr.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <courier.4198D779.00011623@outpost.mndmttr.nl>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Luuk van Dijk <lvd@mndmttr.nl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Luuk van Dijk wrote:
> I have access to a 'raw' sp/diff datastream through a PCM channel.

I guess this would be SNDRV_PCM_FORMAT_IEC958SUBFRAME_xE.

> is there a generic sp/diff encaps/decaps layer in the ALSA driver?

There is an iec958 plugin (see alsa-lib/src/pcm/pcm_iec958.c).


Best regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
