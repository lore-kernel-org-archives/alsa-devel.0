From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Buffer size for ALSA USB PCM audio
Date: Thu, 29 Aug 2013 14:42:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1308291441100.1170-100000@iolanthe.rowland.org>
References: <CABRv+93oVW0rDEJnNeGyfqem2PM42b28-z9q+Ze8r7rky7szDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by alsa0.perex.cz (Postfix) with SMTP id D7F46265580
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 20:42:23 +0200 (CEST)
In-Reply-To: <CABRv+93oVW0rDEJnNeGyfqem2PM42b28-z9q+Ze8r7rky7szDA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: James Stone <jamesmstone@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Eldad Zack <eldad@fogrefinery.com>, USB list <linux-usb@vger.kernel.org>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 29 Aug 2013, James Stone wrote:

> At 32 frames/period (reported round-trip latency 1.33ms), it starts up
> but there are too many xruns for it to be usable.

Interesting.  Can you try doing the same thing with just playback, no 
recording?  If that still gets underruns, please collect a usbmon 
trace.

Alan Stern
