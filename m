From: Abramo Bagnara <abramo@alsa-project.org>
Subject: About integer64
Date: Thu, 09 May 2002 10:10:10 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CDA2EE2.A3C6D824@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>, Paul Davis <pbd@Op.Net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I don't think that's a bad thing to have support for 64 bit integers
(perhaps for future use, who knows), but I think that to use this to
store a fixed point float is a big mistake.

If you think for it you realize that it's *not* an integer and
applications are betrayed in their expectation.

I see two possible solutions:
1) convert internal representation to float (or double) and add support
for this type of data
2) use SNDRV_CTL_ELEM_TYPE_BYTES

As I've already said I prefer 1) but too 2) is far better that to have a
wrong use of a data type.

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
