From: Pedro Ferreira <ilzogoiby@gmail.com>
Subject: USB midi support for KAOSS pad
Date: Mon, 24 May 2010 17:07:22 +0200
Message-ID: <AANLkTimUYbWSqsahW9m8AbIjZuT-yVvnkGpnfCrLyi8u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.221.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 940C62465A
	for <alsa-devel@alsa-project.org>;
	Mon, 24 May 2010 17:07:26 +0200 (CEST)
Received: by qyk9 with SMTP id 9so5539281qyk.2
	for <alsa-devel@alsa-project.org>; Mon, 24 May 2010 08:07:24 -0700 (PDT)
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

Hello all,

I tried connecting my KAOSS PAD 3 to a linux laptop, and apparently
ALSA MIDI detects the device.
However, dmesg shows several messages, all similar to:

{{{
[ 7088.722283] ALSA midi.c:1597: MIDIStreaming version 01.00
[ 7088.722290] ALSA midi.c:1632: EP 02: 1 jack(s)
[ 7088.722295] ALSA midi.c:1647: EP 82: 1 jack(s)
[ 7088.722315] ALSA midi.c:1567: created 1 output and 1 input ports
[ 7088.806326] usb 2-1.1: reset full speed USB device using ehci_hcd
and address 15
}}}

If i open qjackctl, i can see the device being added and removed successively.

Does anyone know what can be going wrong? I would be more than happy
to contribute with usbmon logs, etc... or even try to research a bit
if someone points me in the right direction.

Thanks in advance,

Pedro
