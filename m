From: Frank Uepping <Frank.Uepping@epost.de>
Subject: reeintrant
Date: Mon, 18 Feb 2002 22:43:24 +0100
Message-ID: <3C71757C.E17433AA@epost.de>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
is the ALSA libAPI0.5 reeintrant/thread-save?
I want to develop an multi-threaded application that does playbacking
and recording in separate threads.
I determined from the documentation that I have two possibilities to achieve this:
1.) Playbacking/recording on a single handle (mode PLAYBACK|CAPTURE).
2.) Playbacking/recording on separte handles.
What is cheaper?

Regards
    FAU



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
