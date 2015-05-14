From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Intel DG45ID 5stack (No line in)
Date: Thu, 14 May 2015 16:46:52 +0800
Message-ID: <CAN8cciYQHz4w7x_rt=BCHv9-8pANkOJwYWGzX4ZFK7kvEBASuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f169.google.com (mail-ob0-f169.google.com
 [209.85.214.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FF4826066B
 for <alsa-devel@alsa-project.org>; Thu, 14 May 2015 10:46:53 +0200 (CEST)
Received: by obblk2 with SMTP id lk2so48526722obb.0
 for <alsa-devel@alsa-project.org>; Thu, 14 May 2015 01:46:52 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philip Rhoades <phil@pricom.com.au>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> I have been using this MotherBoard for years (it is probably the most
reliable one I have ever had):

>   http://www.intel.com/p/en_US/support/highlights/dsktpboards/dg45id

> but from the beginning I had trouble with ALSA and the Line In port -
documented here:


>
http://mailman.alsa-project.org/pipermail/alsa-devel/2009-February/014825.html

> Mostly this has not been a problem since I only use the Line In port on
infrequent occasions but it is annoying that when I do need to use it,
sometimes, the method I have found to activate the port does not work
and now using it seems to have permanently messed up the configuration
for Back Mic for normal use somehow.  I have installed Fedora 22 on a
new drive (currently using 21) and booting on the new disk cures the
introduced problem so it appears not to be permanent sound card damage
at all and just some sort of caching or other issue.  My procedure for
getting the Line In port used to be this (although it didn't work this
time and just caused a problem with the Back Mic):

> - uninstall PulseAudio (or rename /usr/bin/pulseaudio)

> - stop all apps auto starting that use ALSA

> - reboot

> - systemctl stop alsa-state.service

> - echo 0x0c 0x01813021 > /sys/class/sound/hwC0D2/user_pin_configs

> - echo 1 > /sys/class/sound/hwC0D2/reconfig

> - chmod -R 777 /dev/snd

> - systemctl start alsa-state.service

> Going through this procedure showed up new controls in xfce4-mixer and
everything worked fine for what I wanted to do - a reboot restored the
original setup (it could also be done with echoing the original values).
  It has been some years since I used this technique but now I can't get
it to work and some of the new controls that show up in xfce4-mixer
("Capture 1", "Input Source 1")
don't disappear with a reboot - even if I:

>   rm .config/xfce4/xfconf/xfce-perchannel-xml/xfce4-mixer.xml

> !?  Also, from Audacity I can now no longer select "Default" for the
microphone and I can't get any of the other options to record . .

> Is anybody able to tell me what is going on?  I can just starting using
F22 on the new drive and forget about using this procedure in the future
but I don't like not knowing why things don't work reliably . .

> Any useful information would be appreciated

you have to post the output of alsa-info.sh

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=52dc438606d1ef78b96f56cc04dbea9242005730

pin fixup seem using [Jack] Speaker instead of [Jack] Line Out at Ext Rear

  Pin Default 0x01014010: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green

Pin Default 0x01011012: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Black

  Pin Default 0x01016011: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Orange

Line in not assigned correctly

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=4d26f44657915f082806abfe3624aeded4c121fa

static const struct hda_pintbl intel_dg45id_pin_configs[] = {
    { 0x0a, 0x02214230 },
    { 0x0b, 0x02A19240 },
-    { 0x0c, 0x01013214 },
+    { 0x0c, 0x01813021 },
    { 0x0d, 0x01014210 },
    { 0x0e, 0x01A19250 },
    { 0x0f, 0x01011212 },
    { 0x10, 0x01016211 },
    {}
};
