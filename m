From: Olivier Langlois <olivier@trillion01.com>
Subject: Re: [PATCH v3 0/5] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Fri, 08 Nov 2013 13:17:02 -0500
Message-ID: <1383934622.22680.2.camel@Wailaba2>
References: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>
 <5269665E.9050102@iki.fi> <1383887323.6455.37.camel@Wailaba2>
 <527CBC7F.4000805@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy1-pub.mail.unifiedlayer.com
 (oproxy1-pub.mail.unifiedlayer.com [66.147.249.253])
 by alsa0.perex.cz (Postfix) with SMTP id 46573261724
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2013 19:17:06 +0100 (CET)
In-Reply-To: <527CBC7F.4000805@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Peter =?ISO-8859-1?Q?Fr=FChberger?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org


> > 
> > What is sound-next? A git branch? Where can I get it?
> 
> The sound tree is at:
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/
> 
> You can use the master branch now, it has been merged there.
> 
I'm no git expert but I had problem cloning the repository:

lano1106@whippet2 ~/dev $ git clone
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/
Cloning into 'sound'...
error: Unable to find 97c4de8fc0a47b99220b1209c7457c7dde05637a under
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git
Cannot obtain needed object 97c4de8fc0a47b99220b1209c7457c7dde05637a
while processing commit ff8c5075a3b474cd9e422eb7e5a97e48f38a9b08.


but I did cherrypicked successfully hda_codec,hda_jack,hda_eld and
patch_hdmi modules from the browser interface of the repo and 3.11.7 did
compile fine.

I'll probably be able to report the testing of your patch sometime later
this afternoon.
