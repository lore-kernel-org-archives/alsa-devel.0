From: Ryan Pavlik <rpav@mephle.com>
Subject: OSS emulation delays (?)
Date: Thu, 23 Oct 2003 12:45:42 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031023124542.0868bfd8.rpav@mephle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hmm, I recently updated to the latest CVS, and there seems to be a
considerable delay while attempting to open or manipulate OSS devices.
I'd search through the mailing list, but the alsa-project.org site
search is (still?) broken.

For instance, when trying to use ALSA/OSS emulation, xmms takes like 5
seconds between the time I hit play and the time it actually starts
playing.   MPlayer isn't quite so slow, but there is a decent pause
while seeking in movies.  With the xmms ALSA driver, this is not a
problem.  Unfortunately mplayer and ALSA don't seem to get along with
my card (ice1712... maudio delta-44), but with audio disabled seek
times are fine.

I would be suprised if this hasn't been noticed, but I haven't seen it
mentioned here.

-- 
Ryan Pavlik <rpav@mephle.com>

"Just *once* I'd like to go a day without being doomed." - 8BT


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
