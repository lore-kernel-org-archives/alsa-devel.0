From: Mike Hearn <mike@plan99.net>
Subject: Re: Switch to dmix pure by default?
Date: Wed, 19 Oct 2005 19:17:37 +0100
Message-ID: <pan.2005.10.19.18.17.37.68892@plan99.net>
References: <20051019154420.GA14091@piware.de> <s5hwtk9jv8g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 19 Oct 2005 19:02:23 +0200, Takashi Iwai wrote:
> dmix uses mmap, and assumes fine enough periods.  So, it wouldn't work
> well the cards supporting only 2 periods, for example.

Is that for performance? I don't really understand why dmix can't just,
well, mix the streams together and then forward it on as a regular
bytestream using the non-mmap interface. Esound works with any hardware,
so couldn't dmix have a compatibility mode?

thanks -mike



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
