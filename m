From: Gilles =?iso-8859-1?q?D=E9gottex?= <gilles.degottex@net2000.ch>
Subject: direct midi event dispatching
Date: Mon, 24 May 2004 14:24:18 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200405241424.18604.gilles.degottex@net2000.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi all,

I'm trying to dispatch midi event directly without queue.
I did every thing I read in the alsa doc (for 
me: /usr/share/doc/libalsa2-docs-1.0.2/seq.html)

but when I flush the output, I got an error: "Invalid argument"
(when calling snd_seq_drain_output)

Meet the same problem ? Got a solution ? Any idea ?

Thanks,
Gilles


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
