From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: usb audio callback questions.
Date: Sun, 06 Jul 2003 14:21:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F082270.8030605@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I have a question regarding the callbacks in the usbaudio.c driver.
The callback is defined as: -

/*
  * complete callback from data urb
  */
static void snd_complete_urb(struct urb *urb, struct pt_regs *regs)


The callback is set up with: -
u->urb->complete = snd_usb_complete_callback(snd_complete_urb);

The issue I have is that urb->complete is of type: -
struct urb;
typedef void (*usb_complete_t)(struct urb *);

struct urb
{
<snip>
         usb_complete_t complete;        // pointer to completion routine
<snip>
};

So, why is the "struct pt_regs *regs" there ?
I would think that
static void snd_complete_urb(struct urb *urb, struct pt_regs *regs)
should change to
static void snd_complete_urb(struct urb *urb)

Cheers
James



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
