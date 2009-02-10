From: Holger Dehnhardt <dehnhardt@ahdehnhardt.de>
Subject: MTP-AV Bugs
Date: Tue, 10 Feb 2009 21:54:32 +0100
Message-ID: <200902102154.32301.dehnhardt@ahdehnhardt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ahdehnhardt.de (ahdehnhardt.de [88.80.200.198])
	by alsa0.perex.cz (Postfix) with ESMTP id 82081243BF
	for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2009 21:55:10 +0100 (CET)
Received: from [88.73.139.241] (helo=musik.localnet)
	by ahdehnhardt.de with esmtpa (Exim 4.63)
	(envelope-from <dehnhardt@ahdehnhardt.de>) id 1LWzdR-0004mv-4A
	for alsa-devel@alsa-project.org; Tue, 10 Feb 2009 21:55:16 +0100
Content-Disposition: inline
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

Hi everybody,

I recently started again to use my older music equipment and try to get it 
work under Linux.

One of these things is an Motu Midi Express XT (8 Port Midi Interface at 
parallel port), which is listed as supported along with the Motu MidiTimePiece 
AV.

After upgrading to a recent Kernel, sending Midi from an Sequencer Programm to 
the Interface was working, but connecting an input port resulted in an 
immediate kernel freeze.

After trying some different parallel port settings and some other things, I 
upgraded to the latest alsa release (alsa-driver-1.0.19) and after the problem 
remains, started debugging the driver. (Because I never did any driver 
programming I only used print statements and returns to locate the point of 
failure..., if anyone of you has a good tutorial about debugging kernel 
modules - please sent a private Mail...)

After some time I found the following bug:

static void snd_mtpav_inmidi_h(struct mtpav *mcrd, u8 inbyte)
{
        if (inbyte >= 0xf8) {
                /* real-time midi code */
-->                snd_mtpav_inmidi_process(mcrd, inbyte);
	//here the inmidiport is not translated to the prtnumber, so 
	// snd_mtpav_inmidi_process the port with an index of some 80000 
	// in the ports array of the mtpav struct was called
                return;
        }

        if (mcrd->inmidistate == 0) {   // awaiting command
                if (inbyte == 0xf5)     // MTP port #
                        mcrd->inmidistate = 1;
                else
                        snd_mtpav_inmidi_process(mcrd, inbyte);
        } else if (mcrd->inmidistate) {
                mcrd->inmidiport = 
			translate_hwport_to_subdevice(mcrd, inbyte);
                mcrd->inmidistate = 0;
        }


The following change made the driver work:
static void snd_mtpav_inmidi_h(struct mtpav *mcrd, u8 inbyte)
{
        if (inbyte >= 0xf8) {
                /* real-time midi code */
		mcrd->inmidiport = translate_hwport_to_subdevice(mcrd, inbyte);
                snd_mtpav_inmidi_process(mcrd, inbyte);
                return;
        }
....


After that I realised, that with the recent driver - even without my change - 
playing midi files din not work anymore.
Only the first midi event was sent to the interface, everything else was 
dropped somewhere.

So a diff between the last workin version and the recent version showed only 
one change:
699,701c703,705
<       card = snd_card_new(index, id, THIS_MODULE, sizeof(*mtp_card));
<       if (! card)
<               return -ENOMEM;
---
>       err = snd_card_create(index, id, THIS_MODULE, sizeof(*mtp_card), 
&card);
>       if (err < 0)
>               return err;

which seems due to an api change. After rolling that back to the old 
(deprecated) way of creating the sound card, everything works fine.

Could someone with a little bit more experience in driver programming please 
look into the first change.

For the second change I would be happy about every tip why the old way works 
and the new way not. I'm willing to correct this as well.

Thank you for listening!

Holger
