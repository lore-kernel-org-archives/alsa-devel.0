From: Brad Midgley <bmidgley@xmission.com>
Subject: Re: alsa-lib plugin devel
Date: Mon, 24 Jan 2005 09:49:49 -0700
Message-ID: <41F5272D.9060101@xmission.com>
References: <Pine.HPX.4.33n.0501240933490.4480-100000@studcom.urz.uni-halle.de>	<41F522DE.30702@xmission.com> <s5hk6q2u659.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk6q2u659.wl@alsa2.suse.de>
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
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi,

> We can create a new API to list up the available PCMs.
> It will help applications, I guess.
> 
> The problem is that plugins which aren't bound to drivers like btsco
> are hard to detect whether they really work in advance.
> Do we need a probe callback for such a plugin?

I suppose there are problems listing things because the plugins behave 
differently. I don't fully understand the problem.

But... it would be a big inconvenience for the user to be told to know 
the device name or go look it up in .asoundrc and/or /etc/asound.conf. 
The {linphone,xine,gnomemeeting} gui should be able to discover and list 
the plugin devices.

Brad


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
