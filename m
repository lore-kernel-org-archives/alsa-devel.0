From: Paul Davis <pbd@op.net>
Subject: Re: how to define a 2-index control element?
Date: Sun, 05 May 2002 09:48:12 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205051347.g45DlKD20979@post2.fast.net>
References: <3CD3DFA3.4395E0B4@alsa-project.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Sat, 04 May 2002 15:18:27 +0200."
             <3CD3DFA3.4395E0B4@alsa-project.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Abramo Bagnara <abramo@alsa-project.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>I suggest you to use the field index of struct sndrv_ctl_elem_id (one
>byte per dimension).
>
>id.index = (source << 8) | destination;

but there are 1400+ possible id's ...

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
