From: Jussi Laako <jussi.laako@kolumbus.fi>
Subject: libasound segfault
Date: Sun, 10 Mar 2002 16:11:22 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3C8B698A.CF0DE577@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

(gdb) bt
#0  0x4015e8d7 in snd_pcm_route_convert1_one () from /usr/lib/libasound.so.2
#1  0x40cae5dc in ?? ()
#2  0x012de908 in ?? ()
Error accessing memory address 0xe8c1018b: No such process.
(gdb)


When reading plughw after requesting 24-bit format. I expect the output
should be 32-bit words with data in upper 24 bits. 16-bit format works and
asking for 32-bit format gives shared memory errors.

alsa-lib-0.9.0beta10a


 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
