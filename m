From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: adding volume to raw-midi device
Date: Wed, 27 Sep 2006 09:28:13 +0200
Message-ID: <1159342093.30849.271951370@webmail.messagingengine.com>
References: <DB99F0250CDF5F438C525F4695C888DC154511@exchange01-srv.pianodisc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <DB99F0250CDF5F438C525F4695C888DC154511@exchange01-srv.pianodisc.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "Pamela K. Clift" <pclift@pianodisc.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Pamela K. Clift wrote:
> when I compile the file I get many errors including "warning:
> struct snd_ctl_elem_info declared inside parameter list"   I have at
> the top of my file #include <sound/control.h> along with the other
> includes I see in the sample files.

struct snd_ctl_elem_info is defined in <sound/asound.h> which is
automatically included by control.h, so I guess the compiler got
confused by some earlier error.

Please show the exact output of the compiler.


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
