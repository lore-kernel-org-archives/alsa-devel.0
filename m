From: Tim Goetze <tim@quitte.de>
Subject: Re: How to send data trough rawmidi ?
Date: Sun, 7 Apr 2002 17:19:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0204071707250.761-100000@summer.quitte>
References: <20020407164211.E1822@pengouin.univ-valenciennes.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Received: from post.webmailer.de (natwar.webmailer.de [192.67.198.70])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA13622
	for <alsa-devel@alsa-project.org>; Sun, 7 Apr 2002 17:21:05 +0200
In-Reply-To: <20020407164211.E1822@pengouin.univ-valenciennes.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Charles =?iso-8859-1?Q?Fl=E8che?= <charles.fleche@meletu.univ-valenciennes.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Charles Fl=E8che wrote:

>Thanx a lot for your help ! I'm working on this project for my=20
>university, and if this soft don't work, I'm going to do another=20
>year... HHAARRRGGGHHHH !

although this is probably not the preferred way (by the ALSA team) of
using the interfaces, you can access MIDI devices like this, too:

/* open ALSA card 0, device 0 */
int fd =3D open ("/dev/snd/midiC0D0", O_WRONLY);

/* write your MicroVerb sysex example */
write (fd, "\xF0\x00\x00\x0e\x12\x00\x03\xF7", 8);

/* done (you may need to keep the device open to let the driver
finish the writing, i'm not sure if it flushes buffers when it's
closed). */
close (fd);

so essentially you skip alsalib and interact with the driver only. i
have found this to be the least painful way of dealing with raw MIDI
streams.

tim
