From: Florian Bomers <Florian.Bomers@sun.com>
Subject: doc bug
Date: Fri, 27 Sep 2002 13:02:49 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D94B968.C6712AAC@sun.com>
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

in alsa-lib/src/pcm/pcm_misc.c:654 function snd_pcm_build_linear_format, the
documentation is:

/**
 * \brief Compose a PCM sample linear format
 * \param width Nominal bits per sample
 * \param pwidth Physical bit width of the format
 * \param unsignd Sign: 0 signed, 1 unsigned
 * \return big_endian Endian: 0 little endian, 1 big endian
 */

but should be something like:

/**
 * \brief Compose a PCM sample linear format
 * \param width Nominal bits per sample
 * \param pwidth Physical bit width of the format
 * \param unsignd Sign: 0 signed, 1 unsigned
 * \param big_endian Endian: 0 little endian, 1 big endian
 * \return format the constructed format or SND_PCM_FORMAT_UNKNOWN on error
 */

The same (last param description given as return description) applies to some
other functions in pcm_misc.c 

Florian


-- 
Florian Bomers
Java Sound
Java Software/Sun Microsystems, Inc.
http://java.sun.com/products/java-media/sound/


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
