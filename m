From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Alsa questions
Date: Mon, 16 Jan 2006 10:23:09 +1100
Message-ID: <1137367389.4823.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3DBD7137
	for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2006 00:23:16 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi !

I'm trying to figure out how to properly design a new sound driver for
powermac with Alsa.

Most earlier machines are easy enough in that they have one codec on one
bus. However, things get more tricky on G5 and newer laptops, where you
end up with more than one bus and multiple codecs (I think both multiple
codecs on one bus and multiple busses with separate codecs setups
exist).

I'm not too sure what kind of relationship Alsa has between PCMs and
mixer devices, and that sort of things yet

The main question that comes to mind is how I represent the multiple
busses. Each bus has an independant pair of DMA channels (playback and
capture). 

 - should I instanciate a different card object for each bus or not ?
Busses _seem_ to be mostly independent, though I yet have to double
check if they have any kind of crossover clocking...

 - should I instanciate one card, but 2 PCM devices ?

 - should I instanciate one card and one PCM device but with 2 playback
and 2 capture substreams ?

It _seems_ to me, but I may be wrong, that the later would mean that you
have N substreams getting in the same codec and beeing mixed, which
isn't the case. My 2 i2s busses are wired to different codecs and thus
different inputs and outputs. However, it's not yet clear to me if both
busses always have both inputs and outputs... I _think_ that in some
models at least, one of the 2 busses is only used for digital input or
output, not sure, I'm still digging into darwin and machine device-trees
to try to write down a complete "map" of apple hw setup.

So if the above feeling is right, that would mean that I need either 2
cards or 2 PCM devices, is that right ?

Then, comes the various codec controls (volumes, mutes, ...)... I am
supposed to set them all to "MIXER" or should I in some way attach them
to the proper PCM on which the codec ?

Another question that comes to mind is locking with external event...
things like input detection interrupts etc... Changing controls seem to
be trivially done with the snd_ctl_notify) interface,  but what about
PCM settings ? For example, if you plug a digital input in, the driver
needs to change all it's internal clocking network and force it's PCM
settings to match the incoming signal. (In fact, it's not even yet clear
to me if I can have a digital input plugged _and_ output at a different
clock rate a different data yet, at least not if they are on the same
i2s bus, but some machine have separate busses so ...). In some cases,
that include changing the PCM format. The typical case where it has the
most impact on the driver is when inputing AC3...


Thanks in advance for your replies,
Cheers,
Ben.




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
