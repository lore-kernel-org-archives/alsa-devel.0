From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: alsa-lib spamming terminal
Date: Fri, 28 May 2004 18:15:11 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <yw1xpt8omsts.fsf@kth.se>
References: <yw1xaczs29y6.fsf@kth.se> <Pine.HPX.4.33n.0405281744340.24462-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Clemens Ladisch <clemens@ladisch.de> writes:

> Måns Rullgård wrote:
>> Is there a way to make alsa-lib stop spamming the terminal with error
>> messages, for instance when a non-blocking open fails?
>
> snd_lib_error_set_handler()

Thanks.  I wonder why I didn't find that when reading the docs.

-- 
Måns Rullgård
mru@kth.se



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
