From: Kasparek Tomas <xkaspa06@stud.fee.vutbr.cz>
Subject: Mixer controls - simple x extended
Date: Sat, 13 Apr 2002 14:45:01 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.BSF.4.44.0204131438350.60325-100000@fest.stud.fee.vutbr.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I just changed the type of some mixer controls in UDA1341 driver to
enumerate. With "amixer" it works fine, showing correct names for all
states. But with "alsamixer" enumarated controls are not showed anymore.

I find, this is because alsamixer uses "simple controls". Is it possible
to setup enumerated controls as simple? Or is there any other way to show
enumarated controls in "alsamixer"?

I thought about rewriting "alsamixer" for "extended" controls, displaying
enumerates as bar with it's index value and printing actual text field at
the end of "Item:" line at the left top corner of alsamixer.
Do you like this solution, or does it cause some troubles? (well, better
should be to just simply enable enumerated controls in actual alsamixer :)

Bye

--

	Tomas Kasparek (sioux, xkaspa06)
 	 tomas.kasparek@[seznam.cz,volny.cz]
	 linux@fit.vutbr.cz
	student FIT VUT Brno
