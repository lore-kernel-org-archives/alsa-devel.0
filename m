From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Conversion from S16 format to ALAW
Date: Wed, 17 Nov 2004 08:37:19 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411170836150.16382-100000@studcom.urz.uni-halle.de>
References: <419A2B91.8070803@ma.tech.ascom.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <419A2B91.8070803@ma.tech.ascom.ch>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Manu Sharma <manu.sharma@ma.tech.ascom.ch>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Manu Sharma wrote:
> I have another question about the warning given in function header of
> snd_pcm_alaw_open (same applies for corresponding mulaw function).
>
> Does the warning suggest that applications should not be using this
> function directly, they should instead configure their alsa.conf and use
> snd_pcm_open ?

Yes.  The way how alsa-lib creates plugins might change in the future.


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
