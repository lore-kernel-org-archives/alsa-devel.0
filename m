From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH]usx2y: prevent oops & dead keyboard on hot
 usb unplugging
Date: Tue, 19 Apr 2005 16:27:49 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0504191619140.11659-100000@studcom.urz.uni-halle.de>
References: <s5h8y3fce7o.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8y3fce7o.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: karsten wiese <annabellesgarden@yahoo.de>, Devel Alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> karsten wiese wrote:
> > P.S.: how about adding a kernelversion depending macro for
> > backward compatibility,... when was
> > snd_card_free_in_thread() introduced?
>
> Agreed.  The problem is that how to know which version has still this
> problem..?  At least, 2.4 kernel must have a problem without
> snd_card_free_in_thread().

I think all 2.6 kernels have reference counted kernel objects.

The actual crash is caused by the class_simple_device_remove() call in
snd_unregister_device() (which is a dummy in kernels before 2.6).
Perhaps this call should be put into the snd_disconnect_device()
function (which doesn't yet exist).


Regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
