From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsa-lib plugin devel
Date: Mon, 24 Jan 2005 09:36:29 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0501240933490.4480-100000@studcom.urz.uni-halle.de>
References: <41F4AF11.2090109@xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <41F4AF11.2090109@xmission.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brad Midgley <bmidgley@xmission.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Brad Midgley wrote:
> 	aplay -B 1000000 -D pcm.a2dp sound.wav
>
> What I'm struggling with is how to make this driver
> appear to clients that use alsa-lib. In the simplest case,
>
> 	aplay --list-devices
>
> Does not show my device in its list!

"aplay -l" shows only hardware devices, i.e., devices that can be
accessed with the hw plugin.

There is no simple enumeration function for plugin pcm's.


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
