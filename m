From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: [ANNOUNCE] alsamixergui and aconnectgui synced with 0.9.0rc1
Date: Fri, 26 Apr 2002 12:30:39 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020426123039.5d1b79f6.mdeboer@iua.upf.es>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: linux-audio-announce@music.columbia.edu, alsa-user@alsa-project.org, alsa-devel@alsa-project.org
Cc: linux-audio-dev@music.columbia.edu, linux-audio-user@music.columbia.edu
List-Id: alsa-devel@alsa-project.org

Hello,

I just updated alsamixergui and aconnectgui. The code is now up to date
with alsa-utils 0.9.0rc1.

alsamixergui and aconnectgui are fltk front-ends for alsamixer
and aconnect.  thet are written directly on top of the alsamixer and
aconnect source, leaving the original source intact, only adding a
couple of ifdefs, and some calls to the gui part, so they provide exactly
the same functionality, but with a  graphical userinterface.

other changes: some bugfixes, most important a layout problem of
aconnectgui

Sources and screenshots can be found at

http://www.iua.upf.es/~mdeboer/projects/

Please let me know if you encounter any problems.

Maarten
