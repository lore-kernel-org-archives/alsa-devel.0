From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: too many alsamixer sliders
Date: Fri, 26 Apr 2002 12:41:15 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020426124115.71b29205.mdeboer@iua.upf.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from iuamtg.upf.es (iuamtg.upf.es [193.145.55.151])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA21258
	for <alsa-devel@alsa-project.org>; Fri, 26 Apr 2002 12:42:25 +0200
Received: from [193.145.55.62] (helo=bitone)
	by iuamtg.upf.es with smtp (Exim 3.34 #1 (Debian))
	id 17138Q-0002LT-00
	for <alsa-devel@alsa-project.org>; Fri, 26 Apr 2002 12:39:26 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

Updating my fltk alsamixer frontend, alsamixergui, I once again
found that alsamixer (and therefore alsamixergui) shows a lot
of sliders. With my Audigy, it's really too much. I think it
would be very nice to be able to configure alsamixer, to show
only a subset of sliders. I guess a .alsamixerrc file in the
users homedirectory. But maybe the /etc/asound.state could be
used for that as well? It would be nice to have several presets
or groups..

Do you have any suggestions about how to do this? I would not
mind implementing it (I think it's won't be to much work), but
I'd like to have your opinion first.

Maarten
