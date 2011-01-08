From: Fernando Lemos <fernandotcl@gmail.com>
Subject: Please add PCI quirk for Vostro 1014 (1028:0401)
Date: Sat, 8 Jan 2011 14:37:22 -0200
Message-ID: <AANLkTi=e=kLUtwStt9yLXO0ZrDfhw2hrZk0LaaFXmXPE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 0B7512441A
	for <alsa-devel@alsa-project.org>; Sat,  8 Jan 2011 17:37:25 +0100 (CET)
Received: by ewy19 with SMTP id 19so7579676ewy.38
	for <alsa-devel@alsa-project.org>; Sat, 08 Jan 2011 08:37:24 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Following the advice received here[1] (thanks, Raymond), I'm asking
for someone to add the following entry to the list of PCI quirks
cxt5066_cfg_tbl if possible:

 SND_PCI_QUIRK(0x1028, 0x02f5, "Dell", CXT5066_DELL_LAPTOP),
+SND_PCI_QUIRK(0x1028, 0x0401, "Dell Vostro 1014", CXT5066_DELL_VOSTRO),
 SND_PCI_QUIRK(0x1028, 0x0402, "Dell Vostro", CXT5066_DELL_VOSTRO),
 SND_PCI_QUIRK(0x1028, 0x0408, "Dell Inspiron One 19T", CXT5066_IDEAPAD),

Codec: Conexant CX20583 (Pebble HSF)
Address: 0
Function Id: 0x2
Vendor Id: 0x14f15067
Subsystem Id: 0x10280401
Revision Id: 0x100300

I can confirm that forcing model=vostro works perfectly for this
specific laptop model (tested speakers and headphones). If there's any
test you want me to do, please let me know. There are more details
about the issue in the aforementioned bug report[1].

By the way, I also got a chance to test on 2.6.37 recently and the
problem persists. In fact, in 2.6.37 I don't even get any sound in my
headphones. But it all works flawlessly with model=vostro.

I apologize if you receive another e-mail from me with similar
contents in the future. I've sent this e-mail to the list last year,
but I wasn't subscribed so I'd been waiting for moderator approval
since then. Now I'm subscribed to the list, let's see if this e-mail
gets through.

[1] https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5184

Thanks in advance,
