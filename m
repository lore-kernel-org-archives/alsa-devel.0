From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-user] [PATCH] emu10k1 multichannel support
Date: Tue, 25 Jan 2005 13:43:05 -0500
Message-ID: <1106678585.10845.8.camel@krustophenia.net>
References: <1106091073.24484.60.camel@krustophenia.net>
	 <1106672990.27843.7.camel@radium.gaugetheory.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1106672990.27843.7.camel@radium.gaugetheory.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brian L Scipioni <brian@gaugetheory.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-01-25 at 12:09 -0500, Brian L Scipioni wrote:
> Lee,
> 
> 	Can you provide instructions for applying the patch?
> 
> 	First I assume I need the latest alsa from CVS, right?
> 

Yes.  I do plan to make a patch against kernel 2.6.10, hopefully I will
get to that today.  For now, here's the quick CVS install HOWTO.  You
must have ALSA compiled as modules for this to work.

$ mkdir cvs/alsa-cvs
$ cd cvs/alsa-cvs
$ cvs -d ":pserver:anonymous@cvs.alsa-project.org:/cvsroot/alsa" co .
$ patch -p1 < emu10k1-multichannel-v005.patch
$ ./build prep
$ cd alsa-driver
$ ./configure --with-cards=emu10k1 --with-kernel=/path/to/kernel/source
$ make && sudo make install

Then just reboot, or rmmod your existing ALSA modules and modprobe the
new ones.

This was only tested on Debian, YMMV.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
