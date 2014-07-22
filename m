From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] ALSA: hda - Add mic fixup for Gigabyte
	BXBT-2807
Date: Tue, 22 Jul 2014 11:42:58 +0100
Message-ID: <CAD8Lp44OBPKaBDK4rD6d-=Nwmn8QyLQpMynC6bQ23V6eFw2_xw@mail.gmail.com>
References: <1406023109-30864-1-git-send-email-drake@endlessm.com>
 <s5hegxdn0wv.wl%tiwai@suse.de>
 <CAD8Lp47W+vpKUNmzryg6dJGXENd_KuBq0o3yYNv9dcuQ9KjAWg@mail.gmail.com>
 <s5hd2cxn0gr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com
 [74.125.82.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 17C10265554
 for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2014 12:43:00 +0200 (CEST)
Received: by mail-we0-f170.google.com with SMTP id w62so8782576wes.1
 for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2014 03:42:58 -0700 (PDT)
In-Reply-To: <s5hd2cxn0gr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 22, 2014 at 11:37 AM, Takashi Iwai <tiwai@suse.de> wrote:
> What if connecting a headphone jack instead of a headset?
>
> Does the device have another mic (internal mic or whatever)?
> The mis-detection of mic jack won't be a big problem if there is a
> single mic input, but if there are two, the driver may switch
> automatically per jack status, thus it becomes a real problem.

Thanks for checking through this.

The only audio capabilities of this mini-PC are the headset jack (via
ALC283 codec), and audio output over HDMI (which appears as another
codec under HDA architecture).
There is no internal mic nor internal speakers.

When nothing is connected:
Pin 0x19 (Not connected): present = No
Pin 0x21 (Black HP Out): present = No

When a headset is connected:
Pin 0x19 (Not connected): present = Yes
Pin 0x21 (Black HP Out): present = Yes

When speakers/simple headphones are connected (no mic):
Pin 0x19 (Not connected): present = No
Pin 0x21 (Black HP Out): present = Yes

In the above output I excluded the other pins which are all "Not
connected" and always seem to have "present = No".

Daniel
