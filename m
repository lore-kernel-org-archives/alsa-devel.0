From: Gregor Jasny <jasny@vidsoft.de>
Subject: Re: Linux 2.6.10 OOPS
Date: Thu, 13 Jan 2005 11:57:43 +0100
Message-ID: <41E65427.1020808@vidsoft.de>
References: <41E63A75.1020107@vidsoft.de> <s5hzmzda9iu.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hzmzda9iu.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>>After removing an USB webcam with a built-in microphone (snd-usb-audio)
>>the kernel oopsed and the PS/2 keyboard wasn't working anymore.
> 
> Yeah this is a known problem.  This seems to be introduced recently.
> IIRC, it didn't happen with the USB stack on 2.6.9.

At least on Fedora Core 3 with 2.6.9-1.667 it is happening, too.
 From a posting on the PWC mailing list:

 > I'm using FC3 with kernel version  2.6.9-1.667 and no other
 > usb devices (in fact no other external devices) on a an
 > ibm thinkpad t42 laptop.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
