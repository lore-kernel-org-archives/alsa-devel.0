From: Paul Davis <pbd@Op.Net>
Subject: Re: Re: Playback stutters
Date: Tue, 19 Mar 2002 23:15:12 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200203200412.XAA07872@renoir.op.net>
References: <20020320150503.A31328@getsystems.com>
In-Reply-To: Your message of "Wed, 20 Mar 2002 15:05:03 +1100."
             <20020320150503.A31328@getsystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Zenaan Harkness <zen@getsystems.com>
Cc: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

>I am getting the same with stock 2.4.18, DELL Inspiron laptop (Maestro
>3i), my test is:
>
>copy a cd image file from one partition to another, while trying to play
>an mp3 using mpg123.
>
>The mp3 skips all over the place.

since you almost certainly have IDE drivers, have you configured them
correctly using hdparm? these are source of considerable scheduling
latency, in ways that AFAIK are not improved by any of the "latency
reducing" patches available. don't ask me how to configure them - i
only use SCSI drives - but a quick google search should reveal
relevant advice.

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
