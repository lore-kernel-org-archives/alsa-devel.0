From: Olivier Langlois <olivier@trillion01.com>
Subject: Re: [PATCH v3 0/5] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Fri, 08 Nov 2013 16:28:39 -0500
Message-ID: <1383946119.1089.4.camel@Wailaba2>
References: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>
 <5269665E.9050102@iki.fi> <1383887323.6455.37.camel@Wailaba2>
 <527CBC7F.4000805@iki.fi> <1383934622.22680.2.camel@Wailaba2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy17-pub.mail.unifiedlayer.com
 (oproxy17-pub.mail.unifiedlayer.com [74.220.201.171])
 by alsa0.perex.cz (Postfix) with SMTP id AA49A265771
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2013 22:28:48 +0100 (CET)
In-Reply-To: <1383934622.22680.2.camel@Wailaba2>
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

On Fri, 2013-11-08 at 13:17 -0500, Olivier Langlois wrote:
> > > 
> > > What is sound-next? A git branch? Where can I get it?
> > 
> > The sound tree is at:
> > https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/
> > 
> > You can use the master branch now, it has been merged there.
> > 
> I'm no git expert but I had problem cloning the repository:
> 
> lano1106@whippet2 ~/dev $ git clone
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/
> Cloning into 'sound'...
> error: Unable to find 97c4de8fc0a47b99220b1209c7457c7dde05637a under
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git
> Cannot obtain needed object 97c4de8fc0a47b99220b1209c7457c7dde05637a
> while processing commit ff8c5075a3b474cd9e422eb7e5a97e48f38a9b08.
> 
> 
> but I did cherrypicked successfully hda_codec,hda_jack,hda_eld and
> patch_hdmi modules from the browser interface of the repo and 3.11.7 did
> compile fine.
> 
> I'll probably be able to report the testing of your patch sometime later
> this afternoon.
> 
Hi Anssi,

here is initial result of my testing of v3 of your patch.

Either my backporting missed something or a regression has slipped into
the newest version but speaker mapping looks slightly broken. I have
this:

lano1106@whippet2 ~ $ speaker-test -D hdmi:CARD=HDMI,DEV=0 -c8 -r192000
-F S32_LE

speaker-test 1.0.27.2

Playback device is hdmi:CARD=HDMI,DEV=0
Stream parameters are 192000Hz, S32_LE, 8 channels
Using 16 octaves of pink noise
Rate set to 192000Hz (requested 192000Hz)
Buffer size range from 8 to 131072
Period size range from 4 to 65536
Using max buffer size 131072
Periods = 4
was set period_size = 32768
was set buffer_size = 131072
 0 - Front Left
 4 - Center
 1 - Front Right
 7 - Side Right
 7 - Side Right
 6 - Side Left
 6 - Side Left
 5 - LFE

With v2, rear channels were there.

Codec: ATI R6xx HDMI
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x1002aa01
Subsystem Id: 0x00aa0100
Revision Id: 0x100300
