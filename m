From: Peter Enderborg <pme@ufh.se>
Subject: Rawmidi bug or missed feature?
Date: Thu, 28 Feb 2002 23:56:35 +0100
Message-ID: <3C7EB5A2.335E82C4@ufh.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I have a program that read's from a raw midi device. In midi there are
some simple compression.
It is assumed that if the data flow is correct, and the data should be
interpreted as paramaters
to previus command if it's not a new command. But when I open a raw midi
stream I can get
in to the stream without having the "previus" command. Is there any way
to do a query or
reset the stream so I can get that command? If it's only one midi
channel sending the same type of command it will never get in to sync!


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
