From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: any support for realtech sound chip
Date: Fri, 23 Jan 2004 10:52:57 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0401231051090.5910-100000@studcom.urz.uni-halle.de>
References: <65120.138.88.11.209.1074803721.squirrel@cocula.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <65120.138.88.11.209.1074803721.squirrel@cocula.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "John W. Cocula" <john@cocula.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

John W. Cocula wrote:
> $ ./speaker-test -Drear -c 2
>
> ALSA lib pcm.c:1812:(snd_pcm_open_conf) Invalid type for PCM rear definition (id: rear, value: cards.pcm.rear)
> Playback open error: Invalid argument

You cannot access the rear channels seperately (at least not
directly). The ICH only supports 2-channel (front), 4-channel
(front+surround) and 6-channel (front+surr+center+lfe) output.


HTH
Clemens




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
