From: Lee Revell <rlrevell@joe-job.com>
Subject: idea for emu10k1 master volume
Date: Wed, 17 Nov 2004 12:30:51 -0500
Message-ID: <1100712652.6930.22.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
Cc: James Courtier-Dutton <James@superbug.co.uk>, Peter Zubaj <pzad@pobox.sk>
List-Id: alsa-devel@alsa-project.org

While hacking the emu10k1 driver I think I found a good way to implement
a master volume control.  There is a master attenuation control for each
voice.  This is pretty much unused - currently you would have to start a
PCM stream then use alsamixer to attenuate it, effectively no
attenuation is ever used.

To implement master volume we just make one control that attenuates all
PCM streams.

-- 
Lee Revell <rlrevell@joe-job.com>



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
