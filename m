From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: alsa-lib plugin devel
Date: Mon, 24 Jan 2005 17:53:04 +0100
Message-ID: <1106585584.8058.61.camel@pegasus>
References: <Pine.HPX.4.33n.0501240933490.4480-100000@studcom.urz.uni-halle.de>
	 <41F522DE.30702@xmission.com>  <s5hk6q2u659.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
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
Cc: Brad Midgley <bmidgley@xmission.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> The problem is that plugins which aren't bound to drivers like btsco
> are hard to detect whether they really work in advance.
> Do we need a probe callback for such a plugin?

I don't think that this is needed. If people want to use a plugin to
access a Bluetooth headset or headphone they need its address and at
least put this in a configuration file. So adding something like

	pcm.aiptek {
	        type a2dp
	        bdaddr "00:0B:0D:50:12:10"
	}

to their .asoundrc to connect to the Aiptek Bluetooth Headphone should
be enough. However these devices should be present in the enumeration of
the applications.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
