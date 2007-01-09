From: Robert Emil Berge <list@rebi.no>
Subject: Re: hda-intel on HP dv2000 (dv2130ea) (CXT5047)
Date: Tue, 9 Jan 2007 22:38:50 +0100
Message-ID: <20070109223850.cc825b08.list@rebi.no>
References: <20070105235244.08aceb43.list@rebi.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20070105235244.08aceb43.list@rebi.no>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I tested some more today, with the latest sources using rsync to download them.
I haven't looked at alsa drivers before, but I thought I'd just look and see what worked. I was curious if it detects the phone jack insertion at all or not. When I load the snd-hda-intel module with model=laptop-hp the cxt5047_hp_unsol_event is triggered when I insert a jack in either of the phone plugs (normal or spdif), and the 
cxt5047_hp_automute is run. But the snd_hda_codec_amp_update commands there don't seem to have any effect on the sound, they're at least not muting the internal speakers.

After compiling my own kernel (2.6.20-rc3) I was able to use the model=test, but then alsamixer wouldn't start, and I got this in /var/log/everything:

Jan  9 01:48:26 audhumla ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 23
Jan  9 01:48:26 audhumla PCI: Setting latency timer of device 0000:00:1b.0 to 64
Jan  9 01:48:26 audhumla ALSA /home/install/alsa/alsa-latest3/alsa-driver/pci/hda/hda_codec.c:1739: hda_codec: model 'test' is selected
Jan  9 01:48:26 audhumla hda_codec: num_steps = 0 for NID=0x19
Jan  9 01:48:28 audhumla hda_codec: num_steps = 0 for NID=0x19
Jan  9 01:48:38 audhumla hda_codec: num_steps = 0 for NID=0x19

If there's anything else I can test that could be helpful, please tell me.

Robert

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
