From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problems with alsactl and via VT8235
Date: Sun, 18 May 2003 12:29:34 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0305181225220.22704-100000@studcom.urz.uni-halle.de>
References: <1053138959.1389.15.camel@multifam-linux>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1053138959.1389.15.camel@multifam-linux>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Guillermo Keil <gkeil@ciudad.com.ar>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Guillermo Keil wrote:
> post-install snd-pcm-oss /bin/alsactl restore  >/dev/null 2>/dev/null
> pre-remove snd-pcm-oss   /bin/alsactl store    >/dev/null 2>/dev/null
>
> This approach works, but restores the last state I manually saved some
> time, not the state just before shutdown.
>
> Why is this happening ?

The second line above tells Linux to save the state when the snd-pcm-oss
module gets unloaded. Either this module isn't unloaded when shutting
down, or your sound card driver is already unloaded at that point.

Try replacing snd-pcm-oss with snd-card-0.


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
