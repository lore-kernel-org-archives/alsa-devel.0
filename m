From: Florian Schmidt <mista.tapas@gmx.net>
Subject: difference between OSS mmap and alsa mmap? [alsa-oss]
Date: Mon, 5 Jul 2004 14:42:51 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040705144251.6a286c94@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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


Hi,

the last thing i can see not working correctly in alsa-oss is the mmap emulation [may closed source apps use OSS with mmap emu]. jcdutton told me on irc that this is due to the differences in OSS mmaping and ALSA mmaping and it might not be possible to resolve these issues..

Well, since i don't know anything about mmap'ing device files, i would be glad if somebody could point me to sources of information about mmap'ing device files and especially the differences in handling of ALSA and OSS..

P.S.: the test case here is running Enemy Territory with aoss. Try it and you will see how alsa-oss' mmap emu fails badly [only some craacks and little chunks of audio audible]..

-- 
Palimm Palimm!
http://affenbande.org/~tapas/wiki



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
