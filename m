From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: Re: Detecting alsa sequencer (dis)connects
Date: Wed, 15 May 2002 14:21:55 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020515142155.19ffff43.mdeboer@iua.upf.es>
References: <E177ee9-0003uZ-00@bitone.upf.es>
	<s5hy9em7k1h.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from iuamtg.upf.es (iuamtg.upf.es [193.145.55.151])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA12677
	for <alsa-devel@alsa-project.org>; Wed, 15 May 2002 14:24:01 +0200
In-Reply-To: <s5hy9em7k1h.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> you can connect a port of aconnectgui to the system port.
> the system port will broadcast a notification with
> SND_SEQ_EVENT_CLIENT/PORT_START, and PORT_SUBSCRIBED/UNSUBSCRIBED
> events if the corresponding action occurs.  checking events can be
> done just like others via poll or select.
> of course, it would be better to ignore the connection of aconnectgui
> itself and the system port.

Thanks Takashi, that works very well.

Maarten

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
