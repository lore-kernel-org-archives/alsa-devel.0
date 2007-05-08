From: "r10 kindsofpeople" <r10kindsofpeople@hotmail.com>
Subject: snd-serial-u16550 overflow problems?
Date: Tue, 08 May 2007 14:36:07 -0500
Message-ID: <BAY117-F2201D66003C25DD596F221CD440@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4656266427726348133=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc2-s30.bay0.hotmail.com (bay0-omc2-s30.bay0.hotmail.com
	[65.54.246.166]) by alsa0.perex.cz (Postfix) with ESMTP id F23CF243A1
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2007 21:36:13 +0200 (CEST)
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

--===============4656266427726348133==
Content-Type: text/plain; format=flowed

{reposting (with apologies) from alsa-user at another user's suggestion}

I'm having what appears to be overflow problems within the snd-serial-u16550 
driver.

I'm using 1.0.14rc1.

When calling "amidi -p hw:0,0,0 -s FILE.SYX" where hw:0,0,0 is the 
snd-serial-u16550 port,  the data coming from the serial port appears to be 
a small fraction (900 bytes) of the total file size (13000 bytes).

If I repeat the experiment, but send to a USB MIDI port, all is well.
If I send the data to the serial port using calls to 
snd_seq_event_output_direct(), and I add a 1 second pause between every 
sysex message, all is well (aside from it taking too long).
I'm logging data directly at the PC serial port using another PC, so I've 
eliminated the possibility that the serial-to-MIDI hardware is losing the 
data.

My code is using blocking mode, and besides, amidi behaves the same way as 
my code.

I'm hesitant to blame the driver code (especially given that last time I did 
this, it was an interrupt configuration problem), but I could use some help 
figuring out where to look next.  Please?

Are there calls I can use to ensure that the previous message has gone out 
before writing the next one?  Given the amount of data I'm sending, should I 
be using snd_seq_event_output and scheduling the events on the queue?

John

_________________________________________________________________
More photos, more messages, more storage—get 2GB with Windows Live Hotmail. 
http://imagine-windowslive.com/hotmail/?locale=en-us&ocid=TXT_TAGHM_migration_HM_mini_2G_0507


--===============4656266427726348133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4656266427726348133==--
