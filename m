From: Paul Davis <pbd@op.net>
Subject: Re: Mixer controls - simple x extended
Date: Sat, 13 Apr 2002 09:54:17 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E16wNxv-00064K-00@usw-sf-list1.sourceforge.net>
References: <Pine.BSF.4.44.0204131438350.60325-100000@fest.stud.fee.vutbr.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Sat, 13 Apr 2002 14:45:01 +0200."
             <Pine.BSF.4.44.0204131438350.60325-100000@fest.stud.fee.vutbr.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Kasparek Tomas <xkaspa06@stud.fee.vutbr.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I just changed the type of some mixer controls in UDA1341 driver to
>enumerate. With "amixer" it works fine, showing correct names for all
>states. But with "alsamixer" enumarated controls are not showed anymore.
>
>I find, this is because alsamixer uses "simple controls". Is it possible
>to setup enumerated controls as simple? Or is there any other way to show
>enumarated controls in "alsamixer"?
>
>I thought about rewriting "alsamixer" for "extended" controls, displaying
>enumerates as bar with it's index value and printing actual text field at
>the end of "Item:" line at the left top corner of alsamixer.
>Do you like this solution, or does it cause some troubles? (well, better
>should be to just simply enable enumerated controls in actual alsamixer :)

the only solution is to modify alsamixer. if it was possible to have
only "simple" controls, the API would contain only "simple"
controls. if you want alsamixer to "work", then it has to be
modified. the typical widget for such things in a pixel-based GUI
would be a "combo box" - you will have work to implement a similar
item with ncurses but it can be done without too much trouble.

but keep in mind that alsamixer will not be able to do everything that
the control API allows unless it becomes very complex. its not clear
that this is a good idea. most people who want character-based
interfaces are reasonably happy with command-line style tools like
aset and amixer; most people who want "graphics" want pixel-based
graphics, not ncurses. its therefore questionable how much work its
worth putting into a ncurses interface.

--p
