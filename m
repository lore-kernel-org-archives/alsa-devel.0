From: thomas charbonnel <thomas@undata.org>
Subject: Re: Alsa and hdspmixer segfault
Date: Sat, 05 Feb 2005 01:37:22 +0100
Message-ID: <1107563842.10562.10.camel@localhost>
References: <200410030444.i934ijUa004509@sanctuary.aproximation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <200410030444.i934ijUa004509@sanctuary.aproximation.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: thewade <pdman@aproximation.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

thewade wrote :
> > > Should I rebuild fltk?
> > 
> > Not always, but what shows the stack trace?
> 
> I rebuilt fltk from source, then rebuilt hdspmixer.
> 
> I started with fltk-1.1.5rc2. That built but had many warnings. I
> moved the libraries installed by fltk-1.1.4-1.1.fc2.dag.x86_64.rpm
> and re-ran ldconfig. I then rebuilt and ran hdspmixer but had the
> same error as before, line 68 in hdspmixer.cxx (see end of email).
> 
> I tried to rebuild fltk-1.2.x but it didnt build.
> Then I tried fltk-2.0.x and that built fine, but hdspmixer
> complained about the declaration (or lack thereof) of many items.
> 
> What should I do?
> Thanks!
> -thewade

Hi,

Sorry for the very late answer, I guess you found a solution since then.
I reply for the record. I just experienced the same problem while
testing the hdsp tools on amd64. It appears that the cr2 helper function
from fltk, called from fl_draw_pixmap, which I use both in hdspconf and
hdspmixer, is badly broken on x86_64 in fltk 1.1.4 (the version shipped
with your FC3, Gentoo and maybe some other distros). I appears to be
fixed in the latest version (1.1.6). Takashi, is there some autoconf
magic we could add to warn about the problem ? Or maybe we could just
add a line to the README file ?

Thomas




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
