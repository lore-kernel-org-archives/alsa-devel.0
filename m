From: Stephan Lachnit <stephanlachnit@protonmail.com>
Subject: ALC255 Fixup (help needed)
Date: Tue, 22 Jan 2019 18:11:40 +0000
Message-ID: <zwOSxXV-WCGfDFx_WLjvl_Se-LJcoPatDvtE1WDFnno8X_wO9vMJali_8HOqLq9qpr6S_qnzx7N9yD25RPLGQEO59Si9rYhnv6BwWSSmHRc=@protonmail.com>
Reply-To: Stephan Lachnit <stephanlachnit@protonmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-40130.protonmail.ch (mail-40130.protonmail.ch
 [185.70.40.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 791DC2674AC
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 19:11:45 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I have a Xiaomi Mi Air 2018 Laptop with one combined 3.5mm jack at the left side of the keyboard, connected via an ALC255.
While audio output with jack detection works fine, alsa doesn't get any mic input.
Internal mic and speakers work fine.

I tried a bit around with hdajackretask and found that Pin ID 0x19 is wired to the mic input.
I uploaded pictures of my config to my stack overflow question: https://stackoverflow.com/questions/54277467/how-to-contribute-to-alsa-intel-hda-config

I know there should be a patch written for sound/pci/hda/patch_realtek.c which should look somewhat like this:

[ALC255_FIXUP_XIAOMI_AIR18] = {
.type = HDA_FIXUP_PINS,
.v.pins = (const struct hda_pintbl[]) {
{ 0x19, 0x01a1913c }, /* combinded audio jack */
},

but I really have no idea what the third and fourth line means and just copied from the Dell fixup. Would be nice if someone could help me to write a proper patch (I have some basic C/C++ knowledge, but no idea about alsa internals).

System Info:
Debian Unstable
libasound2 1.1.7-2
i5 8250U w/ Realtek ALC255

This is my first attempt to contribute to open source project, so I hope I didn't miss anything important.

Best regards,
Stephan Lachnit
