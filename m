From: "M. Ritscher" <mr203010spam@gmx.net>
Subject: Re: libasound dies on snd_pcm_open
Date: Wed, 12 Feb 2003 23:38:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302122338.17609.mr203010spam@gmx.net>
References: <200302112147.45539.mr203010spam@gmx.net> <200302121848.23717.mr203010spam@gmx.net> <s5hd6lxmkgp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd6lxmkgp.wl@alsa2.suse.de>
Content-Description: clearsigned data
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wednesday 12 February 2003 19:18, Takashi Iwai wrote:
> >  if ((err = snd_pcm_open(&capture_hd,
> >          "hwplug:0,0", SND_PCM_STREAM_CAPTURE, 0)) < 0) {
>             ^^^^^^
>
> is this correct?  not "plughw:0,0" ?
Well, sorry, "plughw:0,0" of course. Doesn't change anything though.

Meinhard


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
