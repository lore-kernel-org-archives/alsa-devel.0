From: "Sander van Leeuwen" <sandervl@xs4all.nl>
Subject: C-Media 8378 revision 37 & OPL3 midi
Date: Fri, 19 Jul 2002 11:17:29 +0200 (CDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207190917.g6J9H86o079380@smtpzilla5.xs4all.nl>
Reply-To: "Sander van Leeuwen" <sandervl@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi,

I have two cmedia cards; a revision 37 & 39. Everything
works well on the rev 39 card, but OPL3 midi is silent
on the rev37.
OPL3 initialization succeeds and there are no clear signs
of any problems. My first guess was that this revision
may have a difference (bug) with regards to the FM
volume. However, testing different mute & volume settings 
shows no improvement.
All the IO registers related to FM appear to be working as
specified in the CMedia docs.

Is this a know problem of the ALSA driver, a hardware bug or 
even a defective OPL3 part in this particular revision?

Thanks,

Sander



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
