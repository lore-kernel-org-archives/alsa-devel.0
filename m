From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: OSS emulation buffer size
Date: Mon, 31 Jan 2005 17:21:45 +0100
Message-ID: <1107188505.41fe5b191c972@webmail.uni-halle.de>
References: <20050131041531.5A33988479@sc8-sf-spam1.sourceforge.net>
 <1107176873.6815.40.camel@andys_dellm60.ss82amr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1107176873.6815.40.camel@andys_dellm60.ss82amr.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andy Robinson <andy@seventhstring.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Andy Robinson wrote:
> Hello, I'm trying to find out how to change the size of the buffer which
> ALSA provides for its OSS emulation.
> Where is this controlled from?

AFAIK ALSA uses the maximum size supported by the device, and rounds it
down to a power of two.

> In the app (which I write) which is using OSS I can
> SNDCTL_DSP_SETFRAGMENT but this won't increase the total size.

This can only decrease the buffer size.


What sound card do you have?
What are the contents of /proc/asound/card0/pcm0p/sub0/prealloc?  Try
changing it.


HTH
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
