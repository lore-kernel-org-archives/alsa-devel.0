From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: Driver development: Mixer control naming
Date: Tue, 13 May 2003 12:04:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030513120447.pochini@shiny.it>
References: <20030513011018.11517.h003.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030513011018.11517.h003.c012.wm@mail.icqmail.com.criticalpath.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eliot Blennerhassett <bigblen@icqmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 13-May-2003 Eliot Blennerhassett wrote:
> Hello,
>
> Say I have a card with 4 playback streams each with its
> own volume control.
>
> Each stream can be mixed to any of 4 lineouts.
> (I.e. a matrix mixer with total 16 controls)
> [...]


We talked about a very similar questiont a few weeks
ago. To make it simple, you have some options:

1-
Let snd_kcontrol_new_t .count=1 and write uinfo->count=n;
in the _info callback. This way you have a single control
and you can access the different volumes by
ucontrol->value.integer.value[n] in the callbacks. amixer
will "see" a single control with n items.

2-
Let snd_kcontrol_new_t .count=n and return uinfo->count=1;
in the _info callback. Doing so you have n controls with
the same name but different index. In the callbacks the
index is ucontrol->id.index and its value is always
ucontrol->value.integer.value[0]. amixer will see n
indipendent controls.

3-
I suppose you can mix the above methods too, but I never
tried it. I guess you can lock controls by their id, so
method 2 should allow you to lock each single control.


Bye.



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
