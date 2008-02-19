From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA MIDI interface - plugin
Date: Tue, 19 Feb 2008 09:06:09 +0100
Message-ID: <47BA8DF1.3000407@ladisch.de>
References: <61445c750802140724h1585b495pcc546e2b082e086a@mail.gmail.com>	<s5hfxvuw483.wl%tiwai@suse.de>
	<61445c750802180647l3604fd9fk43426018d9a80e4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id D8D141038DE
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 09:04:23 +0100 (CET)
In-Reply-To: <61445c750802180647l3604fd9fk43426018d9a80e4b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pharaoh . wrote:
> On Feb 15, 2008 10:23 PM, Takashi Iwai <tiwai@suse.de> wrote:
> > Another possibility is to write an ALSA sequencer client, and load
> > snd-virmidi driver.  Then you can connect to a rawmidi device as you
> > like.
>
> Thanks Takashi, I am not sure I understood this fully..Can you point me to
> some sample code or relevant documentation.

There is the old usbmidid daemon that creates sequencer ports for USB
MIDI devices: <http://www.alsa-project.org/~clemens/usbmidid/>.
(It won't install fully on any modern system because the hotplug scripts
have been replaced with udev.)


HTH
Clemens
