From: Haroldo Gamal <gamal@alternex.com.br>
Subject: Problems with __BYTE_ORDER
Date: Sat, 16 Feb 2002 14:17:14 -0200
Message-ID: <5.1.0.14.1.20020216141259.40e038a0@pop.alternex.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
In-Reply-To: <s5hk7ted1en.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi,

	The modification you made on alsa-kernel/include/asound.h carries one problem:

	__BYTE_ORDER is not defined under linux/types.h. It makes a generation of 
wrong SND_BIG_ENDIAN constant on i386 architecture.

	Am I wrong?

	Haroldo Gamal


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
