From: =?ISO-8859-1?Q?Erik_Inge_Bols=F8?= <knan@mo.himolde.no>
Subject: Software volume via LADSPA and .asoundrc
Date: Mon, 3 May 2004 20:24:21 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.56-Maildir.0405032015350.7680@yme.midgardsormen.net>
References: <Pine.HPX.4.33n.0405031002250.11208-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from yme.midgardsormen.net ([158.38.74.10])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id UAA24741
	for <alsa-devel@alsa-project.org>; Mon, 3 May 2004 20:22:02 +0200
In-Reply-To: <Pine.HPX.4.33n.0405031002250.11208-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Nico Schottelius <nico-linux-alsa@schottelius.org>, Bernhard Rosenkraenzer <bero@arklinux.org>, alsa-devel mailing list <alsa-devel@alsa-project.org>, alsa-user mailing list <alsa-user@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 3 May 2004, Clemens Ladisch wrote:
>Nico Schottelius wrote:
>> anyone knows if there is the possibility to adjust sound volume or
>> not.
>
>CMI hardware doesn't have this capability.
>
>It would be possible to write a plugin that scales sound data in
>software before sending it to the device, but nobody has done this
>yet.

Install LADSPA, then try this in your .asoundrc ... adjust the "0.5" to
taste.

Having it show up as an adjustable mixer control for runtime tuning would
be even neater, of course.

pcm._volume {
        type ladspa
        slave.pcm "plughw:0,0";
        path "/usr/local/lib/ladspa";
        playback_plugins [
                {
                        label amp_mono
                        input {
                                controls
                                        [ 0.5 ]
                        }
                }
        ]
}

pcm.!default {
        type plug
        slave.pcm "_volume";
}

--
Erik I. Bols=F8 | email: <knan at mo.himolde.no>
The UNIX philosophy basically involves giving you enough rope to
hang yourself.  And then a couple of feet more, just to be sure.


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
