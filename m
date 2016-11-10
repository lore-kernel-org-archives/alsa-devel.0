From: Paulo Fidalgo <paulo.fidalgo.pt@gmail.com>
Subject: Mic detection on Mackbook Pro 12,1 (CS4208)
Date: Thu, 10 Nov 2016 21:52:52 +0000
Message-ID: <CAKbjie4D=iSKs_+HNpspZufF1GpB6BZATsS=2=9XhyCEe09PSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
 [209.85.161.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AB0C2673BA
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:52:54 +0100 (CET)
Received: by mail-yw0-f181.google.com with SMTP id i145so165059044ywg.2
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 13:52:54 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

After reporting the issue on bugzilla
(https://bugzilla.kernel.org/show_bug.cgi?id=155601) I felt I could do
more in order to try to get a patch to fix the issue.

Basically when I plug an headset(mic+headphone), it only detects the
headphone not the mic.

Since I assumed the "memory address" of the 0x18 pin is wrong, I've
tried to change some values in order to get it working.
I have tries both ways:

1. By changing the kernel souce(sound/pci/hda/patch_cirrus):
in the function
static void cs4208_fixup_mac(struct hda_codec *codec,
                 const struct hda_fixup *fix, int action)

I've added an configuration to set the address of the 0x18.

Then create a script to remove the module, compile, load and test via
arecord if it's working.

2. use the user_pin_configs
basically I've iterated for the range of memory addresses found in the
card config and try to apply them:

for (( num=0x002b4020; num <= 0x90a60100; num+=1 ))
 do
pulseaudio -k
ADDRESS=$(printf "0x%08x\n" $num)
echo "0x18 $ADDRESS" | sudo tee /sys/class/sound/hwC1D0/user_pin_configs
echo "0x1c 0x400000f0" | sudo tee /sys/class/sound/hwC1D0/user_pin_configs
echo 1 | sudo tee /sys/class/sound/hwC1D0/reconfig
pulseaudio -D
arecord -d 5 -vvv -f dat /dev/null 2>&1 | grep -Po " 1\d+%"
done

but since I need to use the computer, I'm doing this in batches.

Both address we're found by alsa-config as the pin addresses.

Now my question is, is there a better way (without brute force) to get
the right address?
Could be anything else, other than the address?

I also have MacOS installed, but from what I've found there's no way
to know the address in MacOS, if there's a way, please point me ;)

Best regards,

Paulo Fidalgo
