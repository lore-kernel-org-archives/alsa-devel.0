From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Kernel debuggers?
Date: Sat, 22 Jan 2005 15:45:00 -0500
Message-ID: <1106426700.5327.12.camel@krustophenia.net>
References: <1106344660.3232.61.camel@krustophenia.net>
	 <20050122201943.GD31651@zewt.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050122201943.GD31651@zewt.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Glenn Maynard <glenn@zewt.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2005-01-22 at 15:19 -0500, Glenn Maynard wrote:
> On Fri, Jan 21, 2005 at 04:57:40PM -0500, Lee Revell wrote:
> > I've been using SoftICE to "debug" some Windows drivers lately ;-), and
> > I have to say it's way better than my current printk-based debug method.
> > Does anyone have any specific recommendations for debugging Linux
> > drivers?  kdb seems to be the obvious choice, I'm building it now.
> > 
> > Does anyone have any other recommendations?
> 
> Not a recommendation, since I've only looked at it and not yet tried it,
> but another is kgdb.
> 

I got kdb up and running, and it works well, it even plays nice with the
RT patch, though I had to edit the kdb patch a little to get it to
apply.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
