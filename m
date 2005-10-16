From: Tilman Kranz <tilman.kranz@tk-sls.de>
Subject: ca0106 with MIDI
Date: Sun, 16 Oct 2005 11:31:36 +0200
Message-ID: <43521DF8.2040401@tk-sls.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.tk-sls.de (linuxfoo.de [83.151.18.109])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C6AF1197
	for <alsa-devel@alsa-project.org>; Sun, 16 Oct 2005 11:31:44 +0200 (MEST)
Received: from [192.168.1.100] (p54AC62B0.dip.t-dialin.net [84.172.98.176])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sls.thelair", Issuer "Tilman Kranz" (verified OK))
	by mail.tk-sls.de (Postfix) with ESMTP id B9ACF30005
	for <alsa-devel@alsa-project.org>; Sun, 16 Oct 2005 11:31:38 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello.

with regards to the "ca0106" driver for the Creative Audigy LS I would 
like to ask if there are activities to make the "Creative External MIDI" 
(MS W* nomenclatura) resp. the "Creative Labs SB Audigy LS MIDI/Game 
port" (Linux PCI name Db. nomenclatura) available.

I have a MIDI In/Out connection attached. I currently am performing a 
variety of tests  using win+sequencer software. 

Specifically:

I run with Linux Kernel 2.6.12.3. I also have access to CVS alsa-kernel.

I appear to have the "SB0312" model of the Audigy LS. Thus, the rest of 
this mail is the output of lspci, first -v without -n to document the 
model name I have, afterwards with -vn as requested on the blacklist.

Greetings,
Tilman.

 $ lspci -n

0000:01:08.0 Multimedia audio controller: Creative Labs SB Audigy LS
        Subsystem: Creative Labs SB0312 Audigy LS
        Flags: bus master, medium devsel, latency 32, IRQ 18
        I/O ports at 9800 [size=32]
        Capabilities: [dc] Power Management version 2

0000:01:08.1 Input device controller: Creative Labs SB Audigy LS 
MIDI/Game port
        Subsystem: Creative Labs SB0312 Audigy LS MIDI/Game port
        Flags: bus master, medium devsel, latency 32
        I/O ports at 9c00 [size=8]
        Capabilities: [dc] Power Management version 2


 $ lspci -vn

0000:01:08.0 0401: 1102:0007
        Subsystem: 1102:1002
        Flags: bus master, medium devsel, latency 32, IRQ 18
        I/O ports at 9800 [size=32]
        Capabilities: [dc] Power Management version 2

0000:01:08.1 0980: 1102:7005
        Subsystem: 1102:1002
        Flags: bus master, medium devsel, latency 32
        I/O ports at 9c00 [size=8]
        Capabilities: [dc] Power Management version 2




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
