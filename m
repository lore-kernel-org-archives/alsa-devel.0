From: Lee Revell <rlrevell@joe-job.com>
Subject: [RFC] ld10k1 roadmap
Date: Sat, 12 Feb 2005 04:51:54 -0500
Message-ID: <1108201914.3647.9.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ld10k1-devel@lists.sourceforge.net
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

OK, I have had a chance to use ld10k1/qlo10k1 lately and wanted to get
some feedback on the next development steps.

The obvious bug that must be fixed is for the DSP window to not
constantly lose the positions of the patches.  This happens whenever you
close qlo10k1 or even change settings.

Also a "Re-align plugins" function would be nice.

Rather than having to select a tool to add an in, out, or FX bus, these
should be selectable from a right click menu.

For the longer term, we will want a shared object plugin API.  This will
allow plugins to generate microcode on the fly or have custom GUIs.
Instead of loading the .emu10k1 file directly, plugins will be written
in C++ and load the emu10k1 microcode from a file or generate it.
Suggestions for the best way to do this are welcome, I am not really a
GUI programming expert and certainly have no idea how to make a QT app
load objects from a file in this way.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
